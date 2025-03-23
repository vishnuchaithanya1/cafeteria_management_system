document.addEventListener("DOMContentLoaded", function () {
    const options = document.querySelectorAll(".option");

    options.forEach(option => {
        option.addEventListener("mouseover", function () {
            option.style.transform = "scale(1.05)";
        });
        option.addEventListener("mouseout", function () {
            option.style.transform = "scale(1)";
        });
    });
});

