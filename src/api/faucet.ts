import axios from 'axios'
import { useMutation } from '@tanstack/vue-query'

declare global {
  interface Window {
    __RUNTIME_CONFIG__?: {
      VITE_API_BASE_URL?: string
      VITE_STELLAR_CONTRACT_ADDRESS?: string
      VITE_SEPOLIA_CONTRACT_ADDRESS?: string
    }
  }
}

const runtime = typeof window !== 'undefined' ? window.__RUNTIME_CONFIG__ : undefined

export const API_URL = (
  runtime?.VITE_API_BASE_URL ||
  import.meta.env.VITE_API_BASE_URL ||
  'http://127.0.0.1:8000'
).replace(/\/$/, '')

// Vite: VITE_* di-embed saat BUILD, bukan runtime!
// Log ini muncul di build Dokploy & browser console untuk verifikasi nilai ke-bake
console.log('[RupiahKU] API_URL =', API_URL, '| runtime =', runtime?.VITE_API_BASE_URL, '| build =', import.meta.env.VITE_API_BASE_URL)

export interface MintPayload {
  wallet_address: string
  amount: number
  network?: string
}

export interface MintResponse {
  message: string
  data: {
    tx_hash: string
    minted_amount?: number
    wallet_address?: string
    status?: string
  }
  errors: any
}

const mintToken = async (payload: MintPayload): Promise<MintResponse> => {
  const { data } = await axios.post<MintResponse>(`${API_URL}/mint`, payload, { timeout: 30000 })
  return data
}

export const useMintToken = () => {
  return useMutation({
    mutationFn: mintToken
  })
}
