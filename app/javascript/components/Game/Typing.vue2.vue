<template>
<div id="typing-game">

  <div>
    <h3>Nurse Typing</h3>
  </div>
  <!-- ゲーム中の画面 -->
  <div v-if="trying">
    <div>
      <h2 v-if="isTypingCorrect">Good!!</h2>
      <h2 v-else>Miss!!</h2>
    </div>
    <div class="words">
      <h1 v-text="currentWord"></h1>
      <h3 v-text="typingText"></h3>
      <p v-text="isTypingCorrect"></p>
      <input ref="inputTyping" v-bind:value="typingText" @input="typingText = $event.target.value" class="form-control">
      <!-- <input ref="inputTyping" type="text" class="form-control" v-model="typingText"> -->
    </div>


    <div>
      <button type="button" class="btn btn-pink btn-lg" @click="start()">やり直す</button>
    </div>


  </div>



  <!-- ゲーム開始前に表示する部分 -->
  <div v-if="!trying">
      <button type="button" class="btn btn-yellow" @click="start()">タイピングゲームをスタート</button>
  </div>
    

  
  
</div>
</template>

<script>

export default {
  data() {
    return{
      trying: false,
      typingText: '',
      loc: 0,
      goodType: 0,
      missType: 0,
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
      solvedWords: []
    }
  },
  

  methods: {
    start() {
      this.trying = true;
      this.solvedWords = [];
      this.$nextTick(() => {
        this.$refs.inputTyping.focus()
      })
    },


  },

  computed:{
    isTypingCorrect(){
      
      // v-modelの入力値が現在出題されている問題と同じなら解答済みの配列にpush。this.typingTextを殻にする
      if(this.typingText == this.currentWord){
        this.solvedWords.push(this.currentWord)
        this.typingText = ''

        if(this.words.length == this.solvedWords.length){
          this.solvedWords = []
          this.trying = false
          console.log(this.goodType)
          console.log(this.missType)
          alert("全問正解")
        }

        return true
      }

      const typingTextLength = this.typingText.length
      return (this.typingText === this.currentWord.slice(0, typingTextLength))
      
    },

    typeStatus(){
      const typingTextLength = this.typingText.length
      console.log(this.typingText)
      if(this.typingText == this.currentWord.slice(0, typingTextLength)){
        console.log("正解")
        this.goodType++
        console.log(this.goodType)
      }else{
        console.log("不正解")
        this.missType++
        console.log(this.missType)
      }
    },
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
    }


  }
  
}
</script>