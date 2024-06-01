const express = require('express');
const multer = require('multer');
const mysql = require('mysql2');
const path = require('path');
const PDFDocument = require('pdfkit'); // Подключение pdfkit
const arialFontPath = path.join(__dirname, 'ArialRegular.ttf');
const app = express();



// Путь к вашим статическим файлам (HTML, CSS и другие)
const staticPath = path.join(__dirname);

// Указываем Express использовать статические файлы из текущей папки
app.use(express.static(staticPath));

// Middleware для обработки JSON тела запросов
app.use(express.json());


// Подключаемся к базе данных
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '12345', // Замените на ваш пароль
    database: 'store' // Замените на имя вашей базы данных
});

connection.connect((err) => {
    if (err) {
        console.error('Ошибка подключения к базе данных: ' + err.stack);
        return;
    }
    console.log('Подключение к базе данных успешно. ID соединения: ' + connection.threadId);
});

// Обработка GET запроса на корневой URL
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'main.html'));
});

// Роут для получения информации о товарах из базы данных
app.get('/products', (req, res) => {
    connection.query('SELECT * FROM products', (err, results) => {
        if (err) {
            console.error('Ошибка выполнения запроса: ' + err.stack);
            res.status(500).json({ error: 'Ошибка выполнения запроса к базе данных' });
            return;
        }
        res.json(results);
    });
});

app.post('/clients', (req, res) => {
    const { username, password } = req.body;

    // SQL запрос для получения пользователя с указанным именем и паролем
    const sql = 'SELECT * FROM store.clients WHERE username = ? AND password = ?';

    // Выполнение SQL запроса
    connection.query(sql, [username, password], (err, results) => {
        if (err) {
            console.error('Ошибка выполнения SQL запроса:', err);
            res.status(500).json({ error: 'Внутренняя ошибка сервера' });
            return;
        }

        if (results.length > 0) {
            // Если найден пользователь с указанным именем и паролем
            const user = results[0];
            res.json({ client_id: user.client_id, isAdmin: user.isAdmin });
        } else {
            // Если пользователь не найден или пароль неверный
            res.status(401).json({ error: 'Неверное имя пользователя или пароль' });
        }
    });
});

app.post('/register', (req, res) => {
    const { username, password, number, delivery, email } = req.body;

    // SQL запрос для вставки нового пользователя
    const sql = 'INSERT INTO clients (username, password, Phone_number, Address, email) VALUES (?, ?, ?, ?, ?)';

    connection.query(sql, [username, password, number, delivery, email], (err, results) => {
        if (err) {
            console.error('Ошибка выполнения SQL запроса:', err);
            res.status(500).json({ error: 'Внутренняя ошибка сервера' });
            return;
        }

        res.json({ success: true });
    });
});

// Запрос к базе данных для получения товаров в корзине клиента
app.get('/cart', (req, res) => {
    const clientId = req.query.client_id;
    const query = `
        SELECT c.client_id, c.product_id, c.quantity, p.name AS product_name, p.price AS product_price, p.image AS product_image
        FROM cart c
        INNER JOIN products p ON c.product_id = p.product_id
        WHERE c.client_id = ?`;

    connection.query(query, [clientId], (error, results) => {
        if (error) {
            console.error('Ошибка при получении корзины:', error);
            res.status(500).send('Ошибка при получении корзины');
        } else {
            res.json(results);
        }
    });
});

app.post('/update-cart', (req, res) => {
    const { client_id, product_id, quantity } = req.body;
    const query = 'UPDATE cart SET quantity = ? WHERE product_id = ? AND client_id = ?';

    connection.query(query, [quantity, product_id, client_id], (error, results) => {
        if (error) {
            console.error('Ошибка при обновлении количества:', error);
            res.json({ success: false });
        } else {
            res.json({ success: true });
        }
    });
});

app.post('/remove-from-cart', (req, res) => {
    const { client_id, product_id } = req.body;
    const query = 'DELETE FROM cart WHERE product_id = ? AND client_id = ?';

    connection.query(query, [product_id, client_id], (error, results) => {
        if (error) {
            console.error('Ошибка при удалении товара:', error);
            res.json({ success: false });
        } else {
            res.json({ success: true });
        }
    });
});

// Проверка наличия товара в корзине и добавление/обновление товара
app.post('/add-or-update-cart', (req, res) => {
    const { client_id, product_id, quantity } = req.body;

    const checkQuery = `SELECT quantity FROM cart WHERE client_id = ? AND product_id = ?`;
    connection.query(checkQuery, [client_id, product_id], (err, results) => {
        if (err) {
            console.error('Ошибка при проверке корзины:', err);
            res.status(500).send('Ошибка сервера');
        } else {
            if (results.length > 0) {
                // Если товар уже есть в корзине, обновляем количество
                const newQuantity = results[0].quantity + quantity;
                const updateQuery = `UPDATE cart SET quantity = ? WHERE client_id = ? AND product_id = ?`;
                connection.query(updateQuery, [newQuantity, client_id, product_id], (err, results) => {
                    if (err) {
                        console.error('Ошибка при обновлении корзины:', err);
                        res.status(500).send('Ошибка сервера');
                    } else {
                        res.json({ success: true, message: 'Количество товара в корзине обновлено' });
                    }
                });
            } else {
                // Если товара нет в корзине, добавляем его
                const insertQuery = `INSERT INTO cart (client_id, product_id, quantity) VALUES (?, ?, ?)`;
                connection.query(insertQuery, [client_id, product_id, quantity], (err, results) => {
                    if (err) {
                        console.error('Ошибка при добавлении товара в корзину:', err);
                        res.status(500).send('Ошибка сервера');
                    } else {
                        res.json({ success: true, message: 'Товар добавлен в корзину' });
                    }
                });
            }
        }
    });
});

app.get('/user', (req, res) => {
    const clientId = req.query.client_id;
    const query = `
        SELECT * FROM store.clients WHERE client_id = ?`;
    console.log(clientId);
    connection.query(query, [clientId], (error, results) => {
        if (error) {
            console.error('Ошибка при получении корзины:', error);
            res.status(500).send('Ошибка при получении корзины');
        } else {
            res.json(results);
        }
    });
});

// Определите функцию updateUserField вне обработчика маршрута
function updateUserField(client_id, field, value) {
    return new Promise((resolve, reject) => {
        const query = `UPDATE clients SET ${field} = ? WHERE client_id = ?`;

        connection.query(query, [value, client_id], (error, results) => {
            if (error) {
                reject(error);
            } else {
                resolve();
            }
        });
    });
}

// Обработчик маршрута для PUT-запроса на обновление данных пользователя
app.put('/updateUser', (req, res) => {
    const { client_id, field, value } = req.body;

    // Вызываем функцию updateUserField, которая была определена ранее
    updateUserField(client_id, field, value)
        .then(() => {
            // Если обновление успешно, отправляем ответ клиенту
            res.status(200).send('Данные пользователя успешно обновлены');
        })
        .catch(error => {
            // Если возникает ошибка, отправляем клиенту сообщение об ошибке
            console.error('Ошибка при обновлении данных пользователя:', error);
            res.status(500).send('Ошибка при обновлении данных пользователя');
        });
});

app.post('/add-product', (req, res) => {
    const { Name, Price, Category_id, description, image } = req.body;

    // SQL запрос для вставки нового пользователя
    const sql = 'INSERT INTO products (Name, Price, Category_id, description, image) VALUES (?, ?, ?, ?, ?)';

    connection.query(sql, [Name, Price, Category_id, description, image], (err, results) => {
        if (err) {
            console.error('Ошибка выполнения SQL запроса:', err);
            res.status(500).json({ error: 'Внутренняя ошибка сервера' });
            return;
        }

        res.json({ success: true });
    });
});


app.get('/generate_quarterly_report', (req, res) => {
    const query = `
        SELECT o.order_id, p.name, p.price, o.quantity, (p.price * o.quantity) AS total
        FROM \`order\` o
        INNER JOIN products p ON o.product_id = p.product_id
        WHERE o.status_id = 5 AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
        ORDER BY o.order_date DESC
    `;

    connection.query(query, (error, results) => {
        if (error) {
            console.error('Ошибка при получении данных о выполненных заказах:', error);
            res.status(500).send('Ошибка при получении данных о выполненных заказах');
        } else {
            console.log(results); // Проверка данных из базы

            const doc = new PDFDocument();
            let filename = 'quarterly_report.pdf';
            filename = encodeURIComponent(filename);

            res.setHeader('Content-disposition', `attachment; filename="${filename}"`);
            res.setHeader('Content-type', 'application/pdf');

            doc.pipe(res);

            doc.registerFont('ArialRegular', arialFontPath);
            doc.font('ArialRegular');
            doc.fontSize(20).text('Quarterly Sales Report', { align: 'center' });
            doc.moveDown();

            let totalSum = 0;

            results.forEach((row, index) => {
                doc.fontSize(12).text(
                    `${index + 1}. ${row.name} - ${row.quantity} x ${row.price} = ${row.total} руб`
                );
                totalSum += row.total;
            });

            doc.moveDown();
            doc.fontSize(16).text(`Total Sales: ${totalSum} руб`, { align: 'centre' });

            doc.end();
        }
    });
});



// Запуск сервера на порте 3001
const port = 3001;
app.listen(port, () => {
    console.log(`Сервер запущен на порту ${port}`);
});
