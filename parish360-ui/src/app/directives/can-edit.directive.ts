import { Directive, Input, TemplateRef, ViewContainerRef } from '@angular/core';
import { PermissionsService } from '../services/common/permissions-api-service';

@Directive({
  selector: '[appCanEdit]',
  standalone: true
})
export class CanEditDirective {
  private screen: string = '';

  constructor(private permissionService: PermissionsService, private templateRef: TemplateRef<unknown>, private viewContainer: ViewContainerRef) { }

  @Input()
  set appCanEdit(screen: string) {
    this.screen = screen;
    this.updateView();
  }

  private updateView(): void {
    const hasPermission = this.permissionService.canEdit(this.screen);
    if (hasPermission) {
      this.viewContainer.createEmbeddedView(this.templateRef);
    } else {
      this.viewContainer.clear();
    }
  }

}
