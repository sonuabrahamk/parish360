import type { ICellRendererParams } from 'ag-grid-community';

export function StatusComponent(params: ICellRendererParams) {
  let status: any;
  if (params.value === 'COMPLETED') {
    return `<div class="text-center"><span class="text-white text-[10px] font-bold font p-1 rounded bg-green-500">${params.value}</span></div>`;
  }
  return `<div class="text-center"><span class="text-white text-[10px] font-bold p-1 rounded bg-yellow-500">${params.value}</span></div>`;
}
