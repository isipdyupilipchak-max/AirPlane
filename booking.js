// booking.js - общий скрипт для формы бронирования на всех страницах

document.addEventListener('DOMContentLoaded', function() {
    const bookingForm = document.querySelector('.booking-form');
    
    // Если формы бронирования на странице нет, выходим
    if (!bookingForm) return;

    const basePrice = parseInt(bookingForm.dataset.basePrice);
    const peopleSelect = document.getElementById('people-count');
    const roomTypeSelect = document.getElementById('room-type');
    const dateInput = document.getElementById('departure-date');
    const totalPriceElement = document.getElementById('total-price');
    const dateError = document.querySelector('.date-error');
    const bookingMessage = document.getElementById('booking-message');

    // Коэффициенты для типов номеров
    const roomMultipliers = {
        'standard': 1.0,
        'comfort': 1.3,
        'luxury': 1.7
    };

    // Функция расчета цены
    function calculatePrice() {
        const peopleCount = parseInt(peopleSelect.value);
        const roomType = roomTypeSelect.value;
        
        // Увеличиваем цену в 1.5 раза за каждого дополнительного человека
        let price = basePrice * (1 + 0.5 * (peopleCount - 1));
        
        // Применяем коэффициент типа номера
        price *= roomMultipliers[roomType];
        
        return Math.round(price);
    }

    // Функция обновления цены
    function updatePrice() {
        const newPrice = calculatePrice();
        totalPriceElement.textContent = newPrice.toLocaleString('ru-RU') + ' ₽';
    }

    // Функция проверки даты
    function validateDate(dateString) {
        if (!dateString) return true; // Пустая дата не проверяется до отправки
        const selectedDate = new Date(dateString);
        const selectedYear = selectedDate.getFullYear();
        return selectedYear >= 2025 && selectedYear <= 2035;
    }

    // Обработчики событий
    peopleSelect.addEventListener('change', updatePrice);
    roomTypeSelect.addEventListener('change', updatePrice);

    dateInput.addEventListener('change', function() {
        if (this.value && !validateDate(this.value)) {
            dateError.style.display = 'block';
        } else {
            dateError.style.display = 'none';
        }
    });

    // Обработка отправки формы
    bookingForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Проверка даты
        if (dateInput.value && !validateDate(dateInput.value)) {
            showMessage('Ошибка: дата должна быть в пределах 2025-2035 годов', 'error');
            return;
        }

        // Проверка заполнения обязательных полей
        if (!dateInput.value) {
            showMessage('Пожалуйста, выберите дату вылета', 'error');
            return;
        }

        // Имитация успешного бронирования
        showMessage('Тур успешно забронирован! С вами свяжется наш менеджер в ближайшее время.', 'success');
        
        // Сброс формы (опционально)
        setTimeout(() => {
            bookingForm.reset();
            updatePrice();
            bookingMessage.style.display = 'none';
        }, 5000);
    });

    function showMessage(text, type) {
        bookingMessage.textContent = text;
        bookingMessage.style.display = 'block';
        bookingMessage.style.backgroundColor = type === 'success' ? '#d4edda' : '#f8d7da';
        bookingMessage.style.color = type === 'success' ? '#155724' : '#721c24';
        bookingMessage.style.border = type === 'success' ? '1px solid #c3e6cb' : '1px solid #f5c6cb';
    }

    // Инициализация цены при загрузке
    updatePrice();
});