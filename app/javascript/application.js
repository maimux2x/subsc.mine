// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "core-js/stable";
import "regenerator-runtime/runtime";

import { createApp } from 'vue';
import Hello from './app.vue';

console.log("lehoo wordl")

document.addEventListener('DOMContentLoaded', () => {
    createApp(Hello).mount('#app');
});
