import { Directive, Input, TemplateRef, ViewContainerRef } from '@angular/core';
import { PermissionsService } from '../services/common/permissions-api-service';

@Directive({
  selector: '[appCanDelete]',
  standalone: true
})
export class CanDeleteDirective {
  private screen: string = '';

  constructor(private permissionService: PermissionsService, private templateRef: TemplateRef<unknown>, private viewContainer: ViewContainerRef) { }

  @Input()
  set appCanDelete(screen: string) {
    this.screen = screen;
    this.updateView();
  }

  private updateView(): void {
    const hasPermission = this.permissionService.canDelete(this.screen);
    if (hasPermission) {
      this.viewContainer.createEmbeddedView(this.templateRef);
    } else {
      this.viewContainer.clear();
    }
  }
}
