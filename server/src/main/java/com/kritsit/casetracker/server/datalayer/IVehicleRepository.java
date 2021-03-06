package com.kritsit.casetracker.server.datalayer;

import com.kritsit.casetracker.shared.domain.model.Defendant;
import com.kritsit.casetracker.shared.domain.model.Vehicle;

import java.util.List;

public interface IVehicleRepository {
    List<Vehicle> getVehicles(Defendant defendant) throws RowToModelParseException;
    void insertVehicle(Vehicle vehicle, Defendant defendant) throws RowToModelParseException;
}
    
