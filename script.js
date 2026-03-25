// Активация мобильного меню
const hamburger = document.querySelector(".hamburger");
const navMenu = document.querySelector(".nav-menu");

hamburger.addEventListener("click", () => {
    hamburger.classList.toggle("active");
    navMenu.classList.toggle("active");
    
    // Блокировка скролла при открытом меню
    document.body.style.overflow = navMenu.classList.contains('active') ? 'hidden' : '';
});

// Закрытие меню при клике на ссылку
document.querySelectorAll(".nav-link").forEach(n => n.addEventListener("click", () => {
    hamburger.classList.remove("active");
    navMenu.classList.remove("active");
    document.body.style.overflow = ''; // Разблокируем скролл
}));

// Закрытие меню при клике вне его области
document.addEventListener('click', (e) => {
    if (!e.target.closest('.navbar') && navMenu.classList.contains('active')) {
        hamburger.classList.remove("active");
        navMenu.classList.remove("active");
        document.body.style.overflow = '';
    }
});

// Плавная прокрутка к якорям
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Обработка формы поиска
document.getElementById('flight-search').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const from = document.getElementById('from').value;
    const to = document.getElementById('to').value;
    const depart = document.getElementById('depart').value;
    
    alert(`Поиск рейсов:\nОткуда: ${from}\nКуда: ${to}\nДата вылета: ${depart}`);
});

// Улучшенный параллакс эффект с проверкой поддержки
function isTouchDevice() {
    return 'ontouchstart' in window || navigator.maxTouchPoints;
}

if (!isTouchDevice()) {
    // Параллакс только для десктопов
    window.addEventListener('scroll', () => {
        const scrolled = window.pageYOffset;
        const parallaxElements = document.querySelectorAll('.parallax-bg, .about-new-parallax-bg');
        
        parallaxElements.forEach(element => {
            const speed = 0.5;
            element.style.transform = `translateY(${scrolled * speed}px)`;
        });
    });
}

// Простой слайдер для отзывов
const testimonialTexts = [
    {
        text: '"Отличный сервис! Менеджер помог подобрать тур в короткие сроки, учли все пожелания. Отдых получился просто незабываемым!"',
        author: 'Анна, Москва',
        img: './images/анна.jpg'
    },
    {
        text: '"Билеты были найдены по самой выгодной цене. Спасибо AirPlane за экономию и комфорт!"',
        author: 'Иван, Санкт-Петербург',
        img: './images/иван.png'
    },
    {
        text: '"Всё прошло идеально. От бронирования до вылета - ни единой проблемы. Обязательно воспользуюсь снова!"',
        author: 'Мария, Екатеринбург',
        img: './images/мария.png'
    }
];

let currentTestimonial = 0;
const testimonialSlide = document.querySelector('.testimonial-slide');

function changeTestimonial() {
    if (testimonialSlide) {
        currentTestimonial = (currentTestimonial + 1) % testimonialTexts.length;
        const testimonial = testimonialTexts[currentTestimonial];
        
        testimonialSlide.innerHTML = `
            <p>${testimonial.text}</p>
            <div class="client-info">
                <img src="${testimonial.img}" alt="${testimonial.author}" loading="lazy">
                <span>${testimonial.author}</span>
            </div>
        `;
    }
}

// Меняем отзыв каждые 5 секунд
if (testimonialSlide) {
    setInterval(changeTestimonial, 5000);
}

// Анимация появления элементов при скролле
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Наблюдаем за карточками и другими элементами
document.querySelectorAll('.about-card, .destination-card, .service-item').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(el);
});

// Оптимизация для мобильных устройств
window.addEventListener('resize', function() {
    if (window.innerWidth > 768 && navMenu.classList.contains('active')) {
        hamburger.classList.remove("active");
        navMenu.classList.remove("active");
        document.body.style.overflow = '';
    }
});





 // Функционал для формы бронирования
        document.addEventListener('DOMContentLoaded', function() {
            const bookingForm = document.querySelector('.booking-form');
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
                }, 3000);
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