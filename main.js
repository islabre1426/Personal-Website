const themeUser = localStorage.getItem('theme');
const themesSelection = document.getElementById('themes-selection');
const themeList = document.querySelectorAll('#themes-selection input[type="radio"]')

if (themeUser != null) {
    // Remove dev-prefered theme and apply user-setting one
    document.body.removeAttribute('class');
    document.body.classList.add(themeUser);

    // Appropriate setting in themes selection
    themeList.forEach((theme) => {
        if (theme.value === themeUser) {
            theme.setAttribute('checked', '');
        };
    });
};

themesSelection.addEventListener('change', (e) => {
    if (e.target.checked) {
        const themeChoosen = e.target.value;

        // Remove previously applied theme and set new one
        document.body.removeAttribute('class');
        document.body.classList.add(themeChoosen);

        localStorage.setItem('theme', themeChoosen);
    };
});