export default async function(eleventyConfig) {
    eleventyConfig.addPassthroughCopy('src/assets');
}

export const config = {
    dir: {
        input: 'src',
    },
    markdownTemplateEngine: 'njk',
    htmlTemplateEngine: 'njk',
};