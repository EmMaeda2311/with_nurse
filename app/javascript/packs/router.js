import Vue from 'vue';
import Router from 'vue-router';
import Home from '../components/Game/Home.vue';
import Typing from '../components/Game/Typing.vue';
import WordQuiz from '../components/Game/WordQuiz.vue';

Vue.use(Router)

export default new Router({
  routes: [{path: '/', component: Home}, {path: '/typing', component: Typing}, {path: '/word-quiz', component: WordQuiz}]
})