import {database} from '@/db';
import {context} from '@/lib/server-ledger';
export async function GET(req:Request){try{const url=new URL(req.url),c=await context(url.searchParams.get('workspace')),expense=url.searchParams.get('expense');const rows=await database().prepare('SELECT id,actor,action,before,after,created FROM activity WHERE scope=? AND (? IS NULL OR expense_id=?) ORDER BY created DESC LIMIT 100').bind(c.scope,expense,expense).all();return Response.json({events:rows.results});}catch{return Response.json({error:'Unable to read activity'},{status:403});}}
