<template>
  <div class="m-4">
    <ButtonSample />
    <StatusDaialog />
  </div>
</template>

<script>
import { defineComponent } from "vue";
import StatusDaialog from "./components/daialog/statusDaialog.vue";

export default defineComponent({
  name: "App",
  component: {
    StatusDaialog,
  },
});
</script>
