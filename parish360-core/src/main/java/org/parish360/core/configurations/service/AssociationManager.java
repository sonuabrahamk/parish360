package org.parish360.core.configurations.service;

import org.parish360.core.configurations.dto.AssociationInfo;

import java.util.List;

public interface AssociationManager {
    AssociationInfo createAssociation(String parishId, AssociationInfo associationInfo);

    AssociationInfo updateAssociation(String parishId, String associationId, AssociationInfo associationInfo);

    AssociationInfo getAssociationInfo(String parishId, String associationId);

    List<AssociationInfo> getListOfAssociations(String parishId);

    void deleteAssociation(String parishId, String associationId);
}
