<template>
  <p>{{ state.message }}</p>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'App',
  setup() {
    return {
      state: {
        message: "Hello Vue3"
      }
    }
  }
})
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>