<template>
<div id="typing-game">
  <h1>Nurse Typing</h1>
  <!-- ゲーム中の画面 -->
  <div v-if="trying">
    <div v-if="!isFinished">
      <p class="read" v-text="currentWord.read"></p>   
      <h3 v-text="currentWord.name"></h3>
      <p ref="target" class="spell" v-text="currentWord.spell"></p>
    </div>
    
    <div>
      <!-- ゲーム終了後のメッセージ -->
      <p v-text="finishMessage"></p>   
      <p v-if="!isFinished" v-text="nowTimerMessage"></p>


      <div v-if="isFinished">
        <p>会員登録するとあなたの成績がみれます</p>
        <a href="./users/sign_up" class="btn btn-pink brn-lg">会員登録</a>
      </div>

    </div>
  </div>

  <!-- カウントダウン -->
  <div v-if="countDownStatus">
    <h3 v-text="countDownTime"></h3>
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
      countDownStatus: false,
      timeLimit: 120 * 1000,
      nowTimerMessage:"",
      startTime: 0,
      startCountTime: 3 * 1000,
      countDownTime: 0,
      loc: 0,
      goodType:0,
      missType:0,
      words:[],
      finishMessage: "",
      //回答済みの問題を入れる
      solvedWords: [],
    }
  },


  methods:{

    start() {
      this.trying = true;
      this.solvedWords = [];
      this.startTime = Date.now();
      this.missType = 0
      this.updateTimer();
    },

    CountDown(){
      this.countDownStatus = true
      this.startTime = Date.now();
      this.startCountDown()
    },


    inputKey(e){
      //ゲームが終わっていたら、キーボード操作を無効
      if(this.isFinished == true){
        return;
      }
      // ゲームが始まっていない状態でEnterが押されたらゲームスタート
      if(this.trying == false && e.key == "Enter"){
        this.CountDown()
      }

      //もし入力した文字と現在の正しい文字が等しくなければmissTypeを＋して以降の処理を無視 
      if(e.key !== this.currentWord.spell[this.loc]){
        this.missType++;
        return;
      }

      //入力が正しければ何文字目を入力しているか＋ 
      this.loc++;
      this.goodType++;
      this.$refs.target.textContent = '_'.repeat(this.loc) + this.currentWord.spell.substring(this.loc)

      if( this.loc === this.currentWord.spell.length){
        if (this.words.length !== 0){
        this.solvedWords.push(this.currentWord)
        }
        this.loc = 0
        console.log(this.solvedWords.length)

        if(this.words.length == this.solvedWords.length){
        this.finishMessage = `正答率${this.showResult}％ タイピングスピード${this.showTypeSpeed}打鍵 / 分`
          this.isFinished = true
          this.loc = 0
             
        }
      } 
    },

    startCountDown(){
      const startTimeLeft = this.startTime + this.startCountTime - Date.now();
      const nowDownTime = (startTimeLeft / 1000).toFixed(0)
      this.countDownTime = nowDownTime
      const timeoutId = setTimeout(() => {
        this.startCountDown()
      },1000)

      if(this.countDownTime < 1){
        this.start()
        this.countDownStatus = false

        clearTimeout(timeoutId);
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
          this.finishMessage = `正答率${this.showResult}％ タイピングスピード${this.showTypeSpeed}打鍵 / 分`
        }, 100)
        this.loc = 0 
      }
    }


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
      return this.goodType + this.missType === 0 ? 0 : (this.goodType / ( this.goodType + this.missType ) * 100).toFixed(1);
    },

    showTypeSpeed(){
      return (this.goodType / ((Date.now() - this.startTime) / 1000)).toFixed(1) * 60;
    }

  },


  mounted(){
    axios
      .get('/api/words.json')
      .then(response => (this.words = response.data))
  },


  created(){
    window.addEventListener('keydown', this.inputKey);
  }   
}
</script>

