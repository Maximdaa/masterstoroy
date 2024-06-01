console.log('Админ панель запущена');
document.getElementById('add-product-form').addEventListener('submit', function(event) {
    event.preventDefault(); // Предотвращаем отправку формы по умолчанию

    // Получаем значения полей ввода
    const productName = document.getElementById('product-name').value;
    const productPrice = document.getElementById('product-price').value;
    const productCategory = document.getElementById('product-category').value;
    const productdescription = document.getElementById('product-description').value;


    // Отправляем данные на сервер для добавления нового товара
    fetch('/add-product', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ name: productName, price: productPrice })
    })
    .then(response => response.json())
    .then(data => {
        // Обновляем список товаров после успешного добавления
        if (data.success) {
            loadProducts();
        } else {
            alert('Ошибка при добавлении товара');
        }
    })
    .catch(error => {
        console.error('Ошибка при добавлении товара:', error);
    });
});

// Функция для загрузки списка товаров
function loadProducts() {
    fetch('/products')
        .then(response => response.json())
        .then(products => {
            const productList = document.getElementById('product-list');
            productList.innerHTML = ''; // Очищаем список перед обновлением

            // Добавляем каждый товар в список
            products.forEach(product => {
                const listItem = document.createElement('li');
                listItem.textContent = `${product.name}: $${product.price}`;
                productList.appendChild(listItem);
            });
        })
        .catch(error => {
            console.error('Ошибка при загрузке списка товаров:', error);
        });
}

// Загружаем список товаров при загрузке страницы
document.addEventListener('DOMContentLoaded', loadProducts);
