import { env } from 'cloudflare:workers';
export function database(){if(!env.DB) throw new Error('Storage unavailable'); return env.DB;}
export function bucket(){if(!env.BUCKET) throw new Error('Receipt storage unavailable'); return env.BUCKET;}
