import markdownIt from 'markdown-it';
import taskLists from 'markdown-it-task-lists';
import { feedPlugin } from '@11ty/eleventy-plugin-rss';

const markdownOptions = {
    html: true,
    linkify: true,
};

const rssOptions = {
    collection: {
        name: 'posts',
        limit: 0,
    },
    metadata: {
        language: 'en',
        title: "Islabre's Personal Website",
        subtitle: 'The personal website of Islabre, a person who likes tech, cuteness, and thinking',
        base: 'https://islabre.fyi',
        author: {
            name: 'Islabre',
            email: 'islabre1426@disroot.org',
        },
    },
};

export default async function(eleventyConfig) {
    eleventyConfig.setLibrary('md', markdownIt(markdownOptions));
    eleventyConfig.amendLibrary('md', (mdLib) => mdLib.use(taskLists, { enabled: true }));
    
    eleventyConfig.addPassthroughCopy('src/assets');

    eleventyConfig.addPlugin(feedPlugin, rssOptions);
}

export const config = {
    dir: {
        input: 'src',
    },
    markdownTemplateEngine: 'njk',
    htmlTemplateEngine: 'njk',
};