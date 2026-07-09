<script setup lang="ts">
import { ref } from 'vue'
import { useMintToken } from '../api/faucet'

const network = ref('stellar')
const walletAddress = ref('')
const amount = ref(100)

const { mutate, isPending, isError, isSuccess, data, error } = useMintToken()

const handleSubmit = () => {
  if (!walletAddress.value) return
  mutate({
    wallet_address: walletAddress.value.trim(),
    amount: amount.value,
    network: network.value
  })
}
</script>

<template>
  <div class="flex flex-col items-center w-full mb-6">
      <h2 class="text-text-primary text-3xl font-semibold text-center">RPK Testnet Faucet</h2>
      <div class="w-full max-w-[200px] border-t-2 border-border-color mt-4"></div>
  </div>

  <div class="border-2 border-border-color bg-bg-color p-8 rounded-md w-[90%] md:w-[70%] lg:w-[60%] mx-auto mt-8">
    <p class="text-text-secondary mb-8 text-center text-sm md:text-base">Dapatkan token RupiahKU (RPK) gratis untuk menguji aplikasi di jaringan Stellar Testnet dan Sepolia Testnet.</p>
    
    <form @submit.prevent="handleSubmit" class="text-left flex flex-col gap-5">
      <div class="flex flex-col">
        <label for="network" class="text-accent text-md font-semibold mb-2">Jaringan (Network)</label>
        <select 
          v-model="network" 
          id="network" 
          required 
          class="w-full p-3 rounded-md bg-bg-color border-2 border-border-color text-text-primary focus:outline-none focus:border-accent transition-colors appearance-none"
        >
          <option value="stellar">Stellar Testnet</option>
          <option value="sepolia">Sepolia Testnet</option>
        </select>
      </div>

      <div class="flex flex-col">
        <label for="wallet_address" class="text-accent text-md font-semibold mb-2">
          {{ network === 'stellar' ? 'Stellar Public Key' : 'Ethereum Wallet Address' }}
        </label>
        <input 
          v-model="walletAddress" 
          type="text" 
          id="wallet_address" 
          :placeholder="network === 'stellar' ? 'G...' : '0x...'" 
          required 
          autocomplete="off"
          class="w-full p-3 rounded-md bg-transparent border-2 border-border-color text-text-primary focus:outline-none focus:border-accent transition-colors"
        />
      </div>
      <div class="flex flex-col">
        <label for="amount" class="text-accent text-md font-semibold mb-2">Jumlah RPK</label>
        <input 
          v-model.number="amount" 
          type="number" 
          id="amount" 
          min="1" 
          max="10000" 
          required 
          class="w-full p-3 rounded-md bg-transparent border-2 border-border-color text-text-primary focus:outline-none focus:border-accent transition-colors"
        />
      </div>
      <button 
        type="submit" 
        :disabled="isPending"
        class="w-full mt-4 flex justify-center items-center gap-2 border-2 border-border-color text-text-primary px-6 py-3 rounded-md hover:bg-border-color/20 disabled:opacity-50 disabled:cursor-not-allowed transition-all font-medium"
      >
        <span v-if="!isPending">Request Token RPK</span>
        <span v-else>Memproses Transaksi...</span>
        <div v-if="isPending" class="w-4 h-4 border-2 border-text-secondary border-t-text-primary rounded-full animate-spin"></div>
      </button>
    </form>

    <div v-if="isSuccess" class="mt-6 p-4 rounded-md text-center text-green-400 border-2 border-green-500/50 bg-green-500/10 text-sm">
      <strong class="text-green-300 text-lg block mb-1">✅ Sukses!</strong>
      Permintaan berhasil diproses
    </div>

    <div v-if="isError && error" class="mt-6 p-4 rounded-md text-left text-red-400 border-2 border-red-500/50 bg-red-500/10 text-sm">
      <strong class="text-red-300">❌ Error:</strong> <br/>
      <template v-if="(error as any).response?.data">
        {{ (error as any).response.data.message }}
        <pre v-if="(error as any).response.data.errors" class="bg-[#1a1d2d] p-3 rounded-md mt-3 overflow-x-auto text-xs border border-border-color">{{ JSON.stringify((error as any).response.data.errors, null, 2) }}</pre>
      </template>
      <template v-else>
        Koneksi Gagal: Pastikan API Faucet sedang berjalan di http://127.0.0.1:8000
      </template>
    </div>
  </div>
</template>
