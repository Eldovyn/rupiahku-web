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

const addTokenToMetaMask = async () => {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const ethereum = (window as any).ethereum
  if (typeof ethereum !== 'undefined') {
    try {
      await ethereum.request({
        method: 'wallet_watchAsset',
        params: {
          type: 'ERC20',
          options: {
            address: import.meta.env.VITE_SEPOLIA_CONTRACT_ADDRESS,
            symbol: 'RPK',
            decimals: 18,
          },
        },
      })
    } catch (error) {
      console.error('Gagal menambahkan token:', error)
    }
  } else {
    alert('MetaMask tidak terdeteksi di browser Anda!')
  }
}

const copyStellarAddress = async () => {
  try {
    await navigator.clipboard.writeText(import.meta.env.VITE_STELLAR_CONTRACT_ADDRESS)
    alert('Contract Address berhasil disalin!\n\nCara tambah di Freighter Wallet:\n1. Buka Freighter\n2. Klik "Manage Assets"\n3. Pilih "Add Custom Asset"\n4. Paste address yang baru saja disalin.')
  } catch (error) {
    console.error('Gagal menyalin:', error)
  }
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

    <div v-if="isSuccess" class="mt-6 p-4 rounded-md text-center text-green-400 border-2 border-green-500/50 bg-green-500/10 text-sm flex flex-col items-center gap-4">
      <div>
        <strong class="text-green-300 text-lg block mb-1">✅ Sukses!</strong>
        Permintaan berhasil diproses
      </div>
      
      <button 
        v-if="network === 'sepolia'" 
        @click="addTokenToMetaMask"
        type="button"
        class="bg-[#F6851B] hover:bg-[#e2761b] text-white px-4 py-2 rounded-md font-medium text-sm transition-colors flex items-center gap-2 shadow-lg shadow-[#F6851B]/20"
      >
        <img src="https://upload.wikimedia.org/wikipedia/commons/3/36/MetaMask_Fox.svg" class="w-5 h-5" alt="MetaMask" />
        Tambah RPK ke MetaMask
      </button>

      <button 
        v-if="network === 'stellar'" 
        @click="copyStellarAddress"
        type="button"
        class="bg-[#1a1d2d] border border-border-color hover:bg-border-color text-text-primary px-4 py-2 rounded-md font-medium text-sm transition-colors flex items-center gap-2 shadow-lg"
      >
        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-400" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
        Salin Address (Untuk Freighter)
      </button>
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
