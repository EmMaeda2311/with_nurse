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
        <button class="btn btn-blue btn-lg" @click="stopGame()">もう一度プレイする</button>
      </div>

    </div>
  </div>


<!-- ゲーム開始前 -->
  <div v-if="!trying">
    <div class="btn btn-yellow btn-lg">Enterを押すと始まります</div>
  </div>
</div>
</template>

<script>
import axios from 'axios';

export default {
  data(){
    return{
      trying: false,
      isFinished: false,
      timeLimit: 10 * 1000,
      startTime: 0,
      nowTimerMessage:"",
      loc: 0,
      goodType:0,
      missType:0,
      words: [
        'red',
        'yellow',
        'blue',
        'black',
        'white',
        'green',
        'pink',
        'silver',
        'gold',
        'purple'
      ],
      finishMessage: "",
      //回答済みの問題を入れる
      solvedWords: []
    }
  },

  methods:{
    start() {
      this.trying = true;
      this.solvedWords = [];
      
      this.startTime = Date.now();
      this.updateTimer();
    },

    stopGame(){
      this.trying = false
      this.isFinished = false
      this.finishMessage = ""
    },

    inputKey(e){
      //ゲームが終わっていたら、キーボード操作を無効
      if(this.isFinished == true){
        return;
      }
      // ゲームが始まっていない状態でEnterが押されたらゲームスタート
      if(this.trying == false && e.key == "Enter"){
        this.start()
      }
      console.log(e.key)

      //もし入力した文字と現在の正しい文字が等しくなければmissTypeを＋して以降の処理を無視 
      if(e.key !== this.currentWord.spell[this.loc]){
        console.log("miss")
        this.missType++;
        return;
      }

      //入力が正しければ何文字目を入力しているか＋ 
      console.log("good")
      this.loc++;
      this.goodType++;
      this.$refs.target.textContent = '_'.repeat(this.loc) + this.currentWord.spell.substring(this.loc)

      if( this.loc === this.currentWord.spell.length){
        this.solvedWords.push(this.currentWord)
        this.loc = 0

        if(this.words.length == this.solvedWords.length){
          const finishedTime = ((Date.now() - this.startTime) / 1000).toFixed(2);
          this.finishMessage = `Finished ${finishedTime} second`
          this.isFinished = true
             
        }
      } 
    },
  
    updateTimer(){
      const timeLeft = this.startTime + this.timeLimit - Date.now();
      const nowTime = (timeLeft / 1000).toFixed(2)
      this.nowTimerMessage = nowTime
      const timeoutId = setTimeout(() => {
        this.updateTimer()
      },10)

      if(this.nowTimerMessage < 0){
        this.isFinished = true

        clearTimeout(timeoutId);
        this.nowTimerMessage = "0.00"
        setTimeout(() => {
          this.finishMessage = `正答率${this.showResult}％ スピード${this.showTypeSpeed}打鍵 / 秒`
        }, 100)
        
      }
    }

  },
  mounted(){
    axios
      .get('/api/words.json')
      .then(response => (this.words = response.data))
  },

  created(){
    window.addEventListener('keydown', this.inputKey);

  },
   
  computed:{

    currentWord(){

      //unsolvedWordsという定数にthis.words配列から要素を取り出し、代入する
      //取り出す要素はsolvedWordsに含まれていない要素
      const unsolvedWords = this.words.filter((word) => {
        //解答されていないものだけ
        return (!this.solvedWords.includes(word))
      })

      //randomIndexという定数に解答されていない要素の配列番号をランダムで取り出す
      //その数字を使って上の未解答配列unsolvedWordsの要素にアクセスする
      const randomIndex = Math.floor(Math.random() * unsolvedWords.length)
      return unsolvedWords[randomIndex]
    },
    showResult(){
      return this.goodType + this.missType === 0 ? 0 : (this.goodType / ( this.goodType + this.missType ) * 100).toFixed(2); 
    },

    showTypeSpeed(){
      return this.goodType / ( this.timeLimit / 1000 )
    }
  }
  
}
</script>

