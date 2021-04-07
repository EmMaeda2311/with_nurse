<template>
<!-- ゲーム中の画面 -->
<div id="typing-game">
  <h1>Nurse Typing</h1>
  <div v-if="trying">
    <p class="read" v-text="currentWord.read"></p>   
    <h3 v-text="currentWord.name"></h3>
    <p ref="target" class="spell" v-text="currentWord.spell"></p>
    <div>
      <!-- ゲーム終了後のメッセージ -->
      <p v-text="finishMessage"></p>   
      <p v-text="nowTimerMessage"></p>

      <div v-if="isFinished">
      </div>

    </div>
  </div>


<!-- ゲーム開始前 -->
  <div v-if="!trying">
    <div class="btn btn-yellow btn-lg">Enterを押すと始まります</div>

    
  </div>
</div>
</template>