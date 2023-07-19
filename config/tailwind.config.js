const defaultTheme = require('tailwindcss/defaultTheme')

let safelist = []
let classes = ['bg', 'border', 'fill', 'text', 'ring']
let colors = ['lime', 'green', 'indigo', 'red', 'orange', 'yellow', 'amber', 'blue', 'emerald', 'sky']
let indexes = ['50', '100', '200', '300', '400', '500', '600', '700']

classes.map(cl => colors.map(color => indexes.map(index => safelist.push("".concat(cl, "-", color, "-", index)))))

module.exports = {
    content: [
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
        './app/views/**/*.{erb,haml,html,slim}',
        './app/components/**/*.{rb,erb,haml,html,slim}',
    ],

    safelist: safelist.concat([
        "top-1/2", "top-1/3", "top-1/4",
    ]),

    theme: {
        extend: {
            fontFamily: {
                sans: ['Inter var', ...defaultTheme.fontFamily.sans],
            },
        },
    },

    plugins: [
        require('@tailwindcss/forms'),
        require('@tailwindcss/aspect-ratio'),
        require('@tailwindcss/typography'),
    ]
}
