import markdownIt from 'markdown-it';

export default async function(eleventyConfig) {
    const markdownOptions = {
        html: true,
        linkify: true,
    };

    eleventyConfig.setLibrary('md', markdownIt(markdownOptions));
    eleventyConfig.addPassthroughCopy('src/assets');
}

export const config = {
    dir: {
        input: 'src',
    },
    markdownTemplateEngine: 'njk',
    htmlTemplateEngine: 'njk',
};