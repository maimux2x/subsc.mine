<template>
  <div>
    <h1>{{ message }}</h1>
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: "",
    };
  },
  created() {
    this.message = "Subsc.mineでサブスクリプションを管理しよう！";
  },
};
</script>
