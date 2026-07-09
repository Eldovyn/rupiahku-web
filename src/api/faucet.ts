import axios from 'axios'
import { useMutation } from '@tanstack/vue-query'

const API_URL = import.meta.env.VITE_API_BASE_URL || 'http://127.0.0.1:8000'

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
  const { data } = await axios.post<MintResponse>(`${API_URL}/mint`, payload)
  return data
}

export const useMintToken = () => {
  return useMutation({
    mutationFn: mintToken
  })
}
