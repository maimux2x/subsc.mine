<template>
  <button class="px-2 rounded-md h11" @click="handleClick">
    <slot />
  </button>
</template>

<script>
  import { defineComponent } from 'vue';
  export default defineComponent({
    name: 'BaseButton',
    emits: {
      click:null,
    },
    setup(_, { emit }) {
      const handleClick = () => {
        emit('click');
      };

      return {
        handleClick,
      };
    },
  });
</script>