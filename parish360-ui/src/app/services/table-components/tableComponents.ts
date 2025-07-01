import type { ICellRendererParams } from 'ag-grid-community';

export function HyperLink(params: ICellRendererParams) {
    const link = `<a href="/${params.value}" class="text-secondary-color hover:underline cursor-pointer">${params.value}</a>`;
    return link;
}