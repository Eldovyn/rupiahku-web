<script setup lang="ts">
import FaucetForm from './components/FaucetForm.vue'
</script>

<template>
  <header class="bg-bg-color/85 backdrop-blur-md sticky top-0 w-full z-50 border-b border-border-color/30 py-4">
      <nav class="mx-auto flex flex-wrap items-center justify-between md:justify-center w-full px-[5%] relative">
          <div class="flex items-center gap-3 text-2xl font-semibold text-text-primary md:absolute md:left-8">
              <span>RupiahKU</span>
          </div>
          <ul class="hidden md:flex items-center gap-8 font-medium">
              <li><a href="#about" class="text-text-secondary hover:text-text-primary transition-colors cursor-pointer text-sm">Tentang</a></li>
              <li><a href="#features" class="text-text-secondary hover:text-text-primary transition-colors cursor-pointer text-sm">Fitur</a></li>
              <li>
                <a href="#faucet" class="text-text-secondary hover:text-text-primary transition-colors cursor-pointer text-sm">
                  Faucet Testnet
                </a>
              </li>
          </ul>
      </nav>
  </header>

  <main class="w-full">
      <section id="about" class="flex flex-col items-center justify-center min-h-[75vh] px-[5%] py-12 text-center gap-8 max-w-4xl mx-auto">
          <div class="flex flex-col text-text-primary items-center">
              <h1 class="text-4xl md:text-5xl font-semibold leading-tight mb-6">
                Stabilitas Rupiah di Era Blockchain
              </h1>
              <p class="text-lg md:text-xl text-text-secondary mb-8 text-center max-w-2xl">
                RupiahKU (RPK) adalah stablecoin inovatif yang di-pegging 1:1 dengan Rupiah. Rasakan pengalaman transaksi lintas batas yang cepat, murah, dan aman menggunakan ekosistem Soroban Smart Contract.
              </p>
              <div class="flex flex-col sm:flex-row items-center justify-center gap-4">
                  <a href="#faucet" class="border-2 border-border-color text-text-primary px-8 py-3 rounded-md hover:bg-border-color/20 transition-all font-medium text-lg">
                    Mulai Minting RPK
                  </a>
              </div>
          </div>
      </section>

      <!-- Supported Tech Section -->
      <section class="py-8 border-y border-border-color/30 bg-black/20 w-full mb-16">
          <div class="max-w-7xl mx-auto px-[5%] flex flex-col items-center">
              <p class="text-text-secondary text-sm font-medium mb-6 tracking-widest uppercase">Didukung Oleh Teknologi</p>
              <div class="flex flex-wrap justify-center items-center gap-8 md:gap-16">
                  <div class="flex items-center gap-2 text-text-primary/70 hover:text-text-primary transition-colors text-xl md:text-2xl font-bold tracking-tight">
                    <img src="https://cdn.simpleicons.org/ethereum/white" alt="Ethereum" class="w-6 h-6 md:w-8 md:h-8" />
                    <span>Ethereum</span>
                  </div>

                  <div class="flex items-center gap-2 text-text-primary/70 hover:text-text-primary transition-colors text-xl md:text-2xl font-bold tracking-tight">
                    <img src="https://cdn.simpleicons.org/stellar/white" alt="Stellar" class="w-6 h-6 md:w-8 md:h-8" />
                    <span>Stellar</span>
                  </div>
                  <div class="flex items-center gap-2 text-text-primary/70 hover:text-text-primary transition-colors text-xl md:text-2xl font-bold tracking-tight">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/3/36/MetaMask_Fox.svg" alt="MetaMask" class="w-6 h-6 md:w-8 md:h-8" />
                    <span>MetaMask</span>
                  </div>
                  <div class="flex items-center gap-2 text-text-primary/70 hover:text-text-primary transition-colors text-xl md:text-2xl font-bold tracking-tight">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 md:w-8 md:h-8" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12V7H5a2 2 0 0 1 0-4h14v4"/><path d="M3 5v14a2 2 0 0 0 2 2h16v-5"/><path d="M18 12a2 2 0 0 0 0 4h4v-4Z"/></svg>
                    <span>Freighter</span>
                  </div>
              </div>
          </div>
      </section>

      <section id="features" class="py-16 px-[5%] max-w-7xl mx-auto">
          <div class="flex flex-col items-center w-full mb-10">
              <h2 class="text-text-primary text-3xl font-semibold text-center">Mengapa Memilih RupiahKU?</h2>
              <div class="w-full max-w-[200px] border-t-2 border-border-color mt-4"></div>
          </div>
          
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6 w-[90%] md:w-[80%] mx-auto">
              <div class="border-2 border-border-color bg-bg-color p-5 rounded-md flex flex-col items-center text-center">
                  <div class="text-4xl mb-4">⚡</div>
                  <h3 class="text-accent text-lg font-semibold mb-2">Super Cepat</h3>
                  <p class="text-text-secondary text-justify">Konfirmasi transaksi dalam hitungan detik berkat konsensus mutakhir jaringan Stellar.</p>
              </div>
              <div class="border-2 border-border-color bg-bg-color p-5 rounded-md flex flex-col items-center text-center">
                  <div class="text-4xl mb-4">🛡️</div>
                  <h3 class="text-accent text-lg font-semibold mb-2">Aman & Transparan</h3>
                  <p class="text-text-secondary text-justify">Dibangun di atas smart contract Soroban yang mutakhir dan terdesentralisasi sepenuhnya.</p>
              </div>
              <div class="border-2 border-border-color bg-bg-color p-5 rounded-md flex flex-col items-center text-center">
                  <div class="text-4xl mb-4">💸</div>
                  <h3 class="text-accent text-lg font-semibold mb-2">Biaya Transaksi Murah</h3>
                  <p class="text-text-secondary text-justify">Ucapkan selamat tinggal pada biaya transfer tinggi. Transaksi RPK sangat terjangkau.</p>
              </div>
          </div>
      </section>

      <section id="faucet" class="py-16 px-[5%] max-w-7xl mx-auto">
          <FaucetForm />
      </section>
  </main>

  <footer class="text-center py-8 px-[5%] text-text-secondary border-t border-border-color mt-8 text-sm">
      <p>&copy; 2026 RupiahKU Stablecoin Project. Built for Stellar Soroban.</p>
  </footer>
</template>
