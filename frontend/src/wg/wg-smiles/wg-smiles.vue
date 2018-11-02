<template>
  <div class="wg-smiles__container">
       <img class="wg-smiles__smile" @click="isClickSmile(k,v)" v-for="(v, k) in smiles" :key="k" :src="v" alt="" srcset="">
  </div>
</template>
<script>
export default {
  data() {
    return {
      smiles: {
        "&#128522;": "/public/img/smiles/D83DDE0A.png",
        "&#128515;": "/public/img/smiles/D83DDE03.png",
        "&#128521;": "/public/img/smiles/D83DDE09.png",
        "&#128518;": "/public/img/smiles/D83DDE06.png",
        "&#128540;": "/public/img/smiles/D83DDE1C.png",
        "&#128523;": "/public/img/smiles/D83DDE0B.png",
        "&#128525;": "/public/img/smiles/D83DDE0D.png",
        "&#128526;": "/public/img/smiles/D83DDE0E.png",
        "&#128530;": "/public/img/smiles/D83DDE12.png",
        "&#128527;": "/public/img/smiles/D83DDE0F.png",
        "&#128532;": "/public/img/smiles/D83DDE14.png",
        "&#128546;": "/public/img/smiles/D83DDE22.png",
        "&#128557;": "/public/img/smiles/D83DDE2D.png",
        "&#128553;": "/public/img/smiles/D83DDE29.png",
        "&#128552;": "/public/img/smiles/D83DDE28.png",
        "&#128528;": "/public/img/smiles/D83DDE10.png",
        "&#128524;": "/public/img/smiles/D83DDE0C.png",
        "&#128516;": "/public/img/smiles/D83DDE04.png",
        "&#128519;": "/public/img/smiles/D83DDE07.png",
        "&#128560;": "/public/img/smiles/D83DDE30.png",
        "&#128562;": "/public/img/smiles/D83DDE32.png",
        "&#128563;": "/public/img/smiles/D83DDE33.png",
        "&#128567;": "/public/img/smiles/D83DDE37.png",
        "&#128514;": "/public/img/smiles/D83DDE02.png",
        "&#128538;": "/public/img/smiles/D83DDE1A.png",
        "&#128533;": "/public/img/smiles/D83DDE15.png",
        "&#128559;": "/public/img/smiles/D83DDE2F.png",
        "&#128550;": "/public/img/smiles/D83DDE26.png",
        "&#128565;": "/public/img/smiles/D83DDE35.png",
        "&#128544;": "/public/img/smiles/D83DDE20.png",
        "&#128545;": "/public/img/smiles/D83DDE21.png",
        "&#128541;": "/public/img/smiles/D83DDE1D.png",
        "&#128564;": "/public/img/smiles/D83DDE34.png",
        "&#128536;": "/public/img/smiles/D83DDE18.png",
        "&#128543;": "/public/img/smiles/D83DDE1F.png",
        "&#128556;": "/public/img/smiles/D83DDE2C.png",
        "&#128566;": "/public/img/smiles/D83DDE36.png",
        "&#128554;": "/public/img/smiles/D83DDE2A.png",
        "&#128555;": "/public/img/smiles/D83DDE2B.png",
        "&#9786;": "/public/img/smiles/263A.png",
        "&#128512;": "/public/img/smiles/D83DDE00.png",
        "&#128549;": "/public/img/smiles/D83DDE25.png",
        "&#128539;": "/public/img/smiles/D83DDE1B.png",
        "&#128534;": "/public/img/smiles/D83DDE16.png",
        "&#128548;": "/public/img/smiles/D83DDE24.png",
        "&#128547;": "/public/img/smiles/D83DDE23.png",
        "&#128551;": "/public/img/smiles/D83DDE27.png",
        "&#128529;": "/public/img/smiles/D83DDE11.png",
        "&#128517;": "/public/img/smiles/D83DDE05.png",
        "&#128558;": "/public/img/smiles/D83DDE2E.png",
        "&#128542;": "/public/img/smiles/D83DDE1E.png",
        "&#128537;": "/public/img/smiles/D83DDE19.png",
        "&#128531;": "/public/img/smiles/D83DDE13.png",
        "&#128513;": "/public/img/smiles/D83DDE01.png",
        "&#128561;": "/public/img/smiles/D83DDE31.png",
        "&#128535;": "/public/img/smiles/D83DDE17.png",
        "&#128373;": "/public/img/smiles/D83DDD75.png",
        "&#128577;": "/public/img/smiles/D83DDE41.png",
        "&#9785;": "/public/img/smiles/2639.png",
        "&#128578;": "/public/img/smiles/D83DDE42.png",
        "&#128579;": "/public/img/smiles/D83DDE43.png",
        "&#128580;": "/public/img/smiles/D83DDE44.png",
        "&#129296;": "/public/img/smiles/D83EDD10.png",
        "&#129297;": "/public/img/smiles/D83EDD11.png",
        "&#129298;": "/public/img/smiles/D83EDD12.png",
        "&#129299;": "/public/img/smiles/D83EDD13.png",
        "&#129300;": "/public/img/smiles/D83EDD14.png",
        "&#129301;": "/public/img/smiles/D83EDD15.png",
        "&#129303;": "/public/img/smiles/D83EDD17.png",
        "&#129315;": "/public/img/smiles/D83EDD23.png",
        "&#129316;": "/public/img/smiles/D83EDD24.png",
        "&#129314;": "/public/img/smiles/D83EDD22.png",
        "&#129312;": "/public/img/smiles/D83EDD20.png",
        "&#129319;": "/public/img/smiles/D83EDD27.png",
        "&#129317;": "/public/img/smiles/D83EDD25.png"
      }
    };
  },
  methods:{
    isClickSmile(codeSmile, srcSmile){
      this.$emit("onClick", [codeSmile, srcSmile]);
    }
  }
};
</script>
