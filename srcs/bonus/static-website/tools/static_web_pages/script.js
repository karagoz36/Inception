document.addEventListener("DOMContentLoaded", () => {
    const recipes = {
        1: {
            title: "Spaghetti Bolognese",
            image: "images/recipe1.jpg",
            ingredients: [
                "200g spaghetti",
                "100g ground beef",
                "1 can of tomato sauce",
                "1 onion, chopped",
                "2 cloves garlic, minced",
                "Salt and pepper to taste"
            ],
            instructions: [
                "Cook spaghetti according to package instructions.",
                "In a pan, sauté onion and garlic, then add ground beef.",
                "Add tomato sauce, salt, and pepper. Simmer for 10 minutes.",
                "Mix the sauce with spaghetti and serve hot."
            ]
        },
        2: {
            title: "Classic Pancakes",
            image: "images/recipe2.jpg",
            ingredients: [
                "1 cup flour",
                "2 tbsp sugar",
                "1 cup milk",
                "1 egg",
                "1 tsp baking powder",
                "Butter for cooking"
            ],
            instructions: [
                "Mix flour, sugar, and baking powder in a bowl.",
                "Add milk and egg, and whisk until smooth.",
                "Heat butter in a pan and pour batter to form pancakes.",
                "Cook until golden on both sides and serve with syrup."
            ]
        },
        3: {
            title: "Fresh Garden Salad",
            image: "images/recipe3.jpg",
            ingredients: [
                "1 cucumber, diced",
                "2 tomatoes, chopped",
                "1 lettuce, shredded",
                "1/2 red onion, thinly sliced",
                "2 tbsp olive oil",
                "1 tbsp vinegar",
                "Salt and pepper to taste"
            ],
            instructions: [
                "Combine all vegetables in a large bowl.",
                "Drizzle olive oil and vinegar on top.",
                "Season with salt and pepper, and toss well.",
                "Serve fresh as a side dish or appetizer."
            ]
        }
    };

    window.showRecipe = function (id) {
        const recipe = recipes[id];
        const displaySection = document.getElementById("recipe-display");

        displaySection.innerHTML = `
            <h2>${recipe.title}</h2>
            <img src="${recipe.image}" alt="${recipe.title}">
            <h3>Ingredients</h3>
            <ul>${recipe.ingredients.map(item => `<li>${item}</li>`).join("")}</ul>
            <h3>Instructions</h3>
            <ol>${recipe.instructions.map(step => `<li>${step}</li>`).join("")}</ol>
        `;
    };
});
