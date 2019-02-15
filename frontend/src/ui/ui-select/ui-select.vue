<template>
  <div class="ui-select" @click="isClick">
    <ui-text
      ref="text"
      :disabled="this.dDisabled"
      :value="this.dValue"
      :caption="this.caption"
      :help="this.dHelp"
      :readonly="true"
      @onFocus="isFocus"
    ></ui-text>
    <input
      class="ui-select__checkbox"
      v-for="(val, key) in dMenu"
      :key="key"
      v-if="val.selected"
      type="checkbox"
      :name="dName"
      :value="val.value"
      checked
    >
    <transition name="ui-select__arrow">
      <div
        class="ui-select__arrow"
        :class="{'ui-select__arrow_disabled':dDisabled}"
        v-if="!dFocus || dDisabled"
        @click="dFocus=!dFocus"
      >
        <i class="fa fa-angle-down"></i>
      </div>
    </transition>
    <transition name="ui-select__arrow_transit">
      <div class="ui-select__arrow_transit" v-if="dFocus && !dDisabled" @click="dFocus=!dFocus">
        <i class="fa fa-angle-down"></i>
      </div>
    </transition>
    <ui-blind :show="dFocus" @onHide="dFocus=false" animate="opacity" class="ui-select__blind">
      <ul ref="menu" class="ui-select__menu" v-show="dFocus">
        <li v-if="cleaner==true" @click="clickClianer" class="ui-select__option ui-select__cleaner">
          <i aria-hidden="true" class="fa fa-times-thin"></i>
          <span class="ui-select__cleaner-option">очистить</span>
        </li>

        <template v-for="(val, key) in sortMenu">
          <template v-if="val.group!=undefined">
            <li
              v-if=" key==0 || sortMenu[key-1].group!=sortMenu[key].group"
              class="ui-select__group"
              :key="key"
            >{{val.group}}</li>
          </template>
          <li
            class="ui-select__option ui-select__option_disabled"
            :key="'option'+key"
            v-if="val.disabled"
          >
            <ui-check-box
              :key="'cheked'+key"
              :name="dName"
              :disabled="true"
              :checked="val.selected"
              :value="val.value"
              v-show="multiple"
            >{{val.option}}</ui-check-box>
            <span v-if="val.disabled">{{val.option}}</span>
          </li>
          <li
            class="ui-select__option"
            :key="'option'+key"
            @click="isClickOption(key)"
            v-if="!val.disabled"
          >
            <ui-check-box
              :key="'cheked'+key"
              :name="dName"
              :disabled="false"
              :checked="val.selected"
              :value="val.value"
              v-if="multiple"
            >{{val.option}}</ui-check-box>
            <span v-if="!multiple">{{val.option}}</span>
          </li>
        </template>
      </ul>
    </ui-blind>
  </div>
</template>
<script>
export default {
  data() {
    return {
      dName: this.name,
      dValue: "",
      dCaption: this.caption,
      dSheckeds: [],
      // multiple: this.multiple,
      dHelp: this.help,
      dMenu: this.menu,
      dDisabled: this.disabled,
      dFocus: false
    };
  },
  props: {
    name: {
      type: String,
      default: ""
    },
    caption: {
      type: String,
      default: ""
    },
    multiple: {
      type: Boolean,
      default: false
    },
    help: {
      type: String,
      default: ""
    },
    disabled: {
      stype: Boolean,
      default: false
    },
    menu: {
      type: Array,
      default() {
        return [];
      }
    },
    typesort: {
      type: String,
      default() {
        return undefined;
      }
    },
    cleaner: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    disableScrolling() {
      var x = window.scrollX;
      var y = window.scrollY;
      window.onscroll = () => {
        window.scrollTo(x, y);
      };
    },
    enableScrolling() {
      window.onscroll = function() {};
    },
    isFocus() {
      this.dFocus = true;
    },
    isClick() {
      this.$emit("onClick");
    },
    isClickOption(key) {
      let copyDMeny = this.dMenu;
      if (this.multiple == true) {
        copyDMeny[key].selected = !copyDMeny[key].selected;
      } else {
        for (let k in copyDMeny) {
          key == k
            ? (copyDMeny[k].selected = true)
            : (copyDMeny[k].selected = false);
        }
      }

      this.dMenu = copyDMeny;

      this.isCreatedValue();

      let selOdjects = [];
      for (let k in copyDMeny) {
        if (copyDMeny[k].selected == true) {
          selOdjects.push(copyDMeny[k]);
        }
      }
      this.$emit("onSelect", selOdjects);
      this.multiple ? (this.dFocus = true) : (this.dFocus = false);
    },
    isCreatedValue() {
      let selValStr = "";
      let selValArr = this.dMenu.filter(function(menuF) {
        return menuF.selected == true;
      });
      for (let k in selValArr) {
        selValStr = selValStr + selValArr[k].option + ",  ";
      }
      this.dValue = selValStr.replace(/,\s*$/, "");
    },
    clickClianer(){
      this.$emit("onSelect", []);
      this.dFocus = false;
    }
  },
  computed: {
    // возвращает отсортированное меню
    sortMenu() {
      let menu = this.dMenu;
      //без сортировки
      if (this.typesort == undefined) {
        return menu;
      }
      //сортировка по алфавиту
      if (this.typesort == "a-z" || this.typesort == "A-Z") {
        return menu.sort(function(a, b) {
          if (a.option > b.option) {
            return 1;
          }
          if (a.option < b.option) {
            return -1;
          }
          return 0;
        });
      }
      //сортировка против алфанита
      if (this.typesort == "z-a" || this.typesort == "Z-A") {
        return menu.sort(function(a, b) {
          if (a.option > b.option) {
            return -1;
          }
          if (a.option < b.option) {
            return 1;
          }
          return 0;
        });
      }
    }
  },
  watch: {
    dFocus(newQ) {
      newQ == true ? this.$emit("onFocus") : this.$emit("onBlur");
      if (newQ == true) {
        var rect = this.$el.getBoundingClientRect();
        let interval = setInterval(() => {
          if (this.$refs.menu != undefined) {
            this.$refs.menu.style.top = rect.bottom - 10 + "px";
            this.$refs.menu.style.left = rect.left + "px";
            this.$refs.menu.style.width = this.$el.clientWidth + "px";
            // console.log(this.$el);
            clearTimeout(interval);
          }
        }, 1);
        this.disableScrolling();
      } else {
        this.enableScrolling();
      }
    },
    menu(newQ) {
      this.dMenu = newQ;
      this.isCreatedValue();
    },
    disabled(newQ) {
      this.dDisabled = newQ;
    },
    help(newQ) {
      this.dHelp = newQ;
    }
  },
  mounted() {
    //отлавливаем событие клика мимо объекта
    window.addEventListener(
      "click",
      event => {
        let ev = event.target;
        let flCl = false;
        while (ev) {
          if (ev == this.$el) {
            flCl = true;
            break;
          }
          if (ev == undefined) {
            flCl = false;
            break;
          }
          ev = ev.parentNode;
        }
        if (!flCl) {
          this.dFocus = false;
        }
      },
      true
    );
  },

  created() {
    this.isCreatedValue();
  }
};
</script>
