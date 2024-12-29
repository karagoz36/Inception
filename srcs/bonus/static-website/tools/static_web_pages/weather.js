document.addEventListener("DOMContentLoaded", () => {
    const cities = {
        paris: "Paris",
        istanbul: "Istanbul",
        london: "London"
    };

    Object.keys(cities).forEach(city => {
        fetch(`https://api.open-meteo.com/v1/forecast?latitude=0&longitude=0&current_weather=true`)
            .then(response => response.json())
            .then(data => {
                document.querySelector(`#${city} p`).innerText = 
                    `Temperature: ${data.current_weather.temperature}°C, Wind Speed: ${data.current_weather.windspeed} km/h`;
            })
            .catch(() => {
                document.querySelector(`#${city} p`).innerText = "Weather data could not be loaded.";
            });
    });
});
