<template>
    <div class="ui-radio" @click="isClick()">
        <span class="ui-radio__radio"
            :class="{'ui-radio__radio_active':dChecked,
                     'ui-radio__radio_disabled':dDisabled}">
            <transition name="ui-radio__radio-point">
                <span class="ui-radio__radio-point" 
                      :class="{'ui-radio__radio-point_disabled':dDisabled}"  
                        v-if="dChecked">
                
                </span>
            </transition>
        </span>
        <input ref="input" :checked="dChecked" class="ui-radio__input" type="radio" :name="dName" :value="dValue">
        <span  class="ui-radio__caption" 
               :class="{'ui-radio__caption_disabled': dDisabled}">
            <slot></slot>
        </span>
    </div>
</template>
<script>
export default {
    name:"ui-radio",
    data(){
        return{
            dValue: this.value,
            dName: this.name,
            dChecked: this.checked,
            dDisabled: this.disabled 
        }
    },
    methods:{
        isClick(){
            if(this.dDisabled==false){
                let checked=this.dChecked
                let brath = this.$parent.$children;
                for(let br in brath){
                    if (brath[br].dName==this.dName) brath[br].dChecked=false;
                }
                this.dChecked=!checked; 
                this.$emit('onClick', this.dChecked);
            }
        }
    },
    props:{
        value:{
            type: String,
            default: ""
        },
        name:{
            type: String,
            default: ""
        },
        checked:{
            type: Boolean,
            default: false
        },
        disabled:{
            type: Boolean,
            default: false
        }
    },
    mounted(){
        if(this.dChecked==true){
            let brath = this.$parent.$children;
            for(let br in brath){
                if (brath[br].dName==this.dName) brath[br].dChecked=false;
            }
            this.dChecked=true; 
        }
    }
}
</script>
