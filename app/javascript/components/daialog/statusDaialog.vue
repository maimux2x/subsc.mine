<template>
  <div>
    <p class="md-2 text-2xl">Dialogs</p>
    <div>
      <StatusModal :visible="daialogVisible" @backdrop-clicked="switchDialog">
        <template #title>
          <p class="font-bold">ダイアログ</p>
        </template>
        <template #body>
          テストテストテストテスト
        </template>
        <template #footer>
          <div class="flex justify-end">
            <SecondaryButton @click="switchDialog">close</SecondaryButton>
          </div>
        </template>
      </StatusModal>
    </div>
    <div class="mb-2">
      <PrimaryButton @click="switchDialog">open</PrimaryButton>
    </div>
  </div>
</template>

<script>
import { defineComponent, ref } from 'vue';
import PrimaryButton from '../buttons/PrimaryButton.vue';
import SecondaryButton from '../buttons/SecondaryButton.vue';
import statusModal from '../statusModal.vue';

export default defineComponent({
  name: 'StatusDialog',
  components: {
    PrimaryButton,
    SecondaryButton,
    statusModal,
  },
  setup() {
    const daialogVisible = ref(false);
    const switchDialog = () => {
      daialogVisible.value = !daialogVisible.value;
    };

    return {
      daialogVisible,
      switchDialog,
    };
  },
});


</script>