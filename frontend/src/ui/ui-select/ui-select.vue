<template>
  <div class="ui-select" @click="isClick">
    <ui-text ref="text" :disabled="this.dDisabled" :value="this.dValue" :caption="this.caption" :help="this.dHelp" :readonly="true" @onFocus="isFocus">
    </ui-text>
    <input class="ui-select__checkbox" v-for="(val, key) in dMenu" :key="key" v-if="val.selected" type="checkbox" :name="dName" :value="val.value" checked>
    <transition name="ui-select__arrow">
      <div class="ui-select__arrow" :class="{'ui-select__arrow_disabled':dDisabled}" v-if="!dFocus || dDisabled" @click="dFocus=!dFocus">
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
        <template v-for="(val, key) in sortMenu">
          <li v-if="key==0 || sortMenu[key-1].group!=sortMenu[key].group" class="ui-select__group" :key="key">
            {{val.group}}
          </li>
          <li class="ui-select__option ui-select__option_disabled" :key="'option'+key" v-if="val.disabled">
            <ui-check-box :key="'cheked'+key" :name="dName" :disabled="true" :checked="val.selected" :value="val.value" v-show="multiple">
              {{val.option}}
            </ui-check-box>
            <span v-if="val.disabled">{{val.option}}</span>
          </li>
          <li class="ui-select__option" :key="'option'+key" @click="isClickOption(key)" v-if="!val.disabled">
            <ui-check-box :key="'cheked'+key" :name="dName" :disabled="false" :checked="val.selected" :value="val.value" v-if="multiple">
              {{val.option}}
            </ui-check-box>
            <span v-if="!multiple">
              {{val.option}}
            </span>
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
    }
  },
  computed: {
    // возвращает отсортированное меню
    sortMenu() {
      let menu = this.dMenu;
      return menu.sort(function(d1, d2) {
        return d1.group.toLowerCase() > d2.group.toLowerCase();
      });
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
