import type { ICellRendererParams } from 'ag-grid-community';

export function HyperLink(params: ICellRendererParams) {
    const link = `<a href="/family-records/${params.value}" class="text-secondary-color hover:underline cursor-pointer">${params.value}</a>`;
    return link;
}