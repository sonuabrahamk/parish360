import { Injectable, computed, signal } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class LoaderService {
  private _loadingCount = signal(0);
  readonly isLoading = computed(() => this._loadingCount() > 0);

  show() {
    this._loadingCount.set(this._loadingCount() + 1);
  }

  hide() {
    this._loadingCount.update(count => Math.max(0, count - 1));
  }

  reset() {
    this._loadingCount.set(0);
  }
}
