//
//  CloudKitContainerStub.swift
//  SalonGoTests
//
//  Created by Yago Marques on 08/11/22.
//

import Foundation
import CloudKit
@testable import SalonGo

final class CloudKitContainerStub: CKContainerProtocol {
    var records = [CKRecord]()

    var recordsAccessCounter = 0

    func save(_ record: CKRecord, completionHandler: @escaping (CKRecord?, Error?) -> Void) {
        records.append(record)
        completionHandler(record, nil)
    }

    func fetch(
        withQuery query: CKQuery,
        completionHandler: @escaping (
            Result<(
                matchResults: [(CKRecord.ID, Result<CKRecord, Error>)],
                queryCursor: CKQueryOperation.Cursor?
            ), Error>
        ) -> Void) {
        var matchResults: [(CKRecord.ID, Result<CKRecord, any Error>)] = []
        for record in records
        where record.recordType == query.recordType {
            recordsAccessCounter += 1
            matchResults.append((record.recordID, .success(record)))
        }

        let result: (
            matchResults: [(CKRecord.ID, Result<CKRecord, any Error>)],
            queryCursor: CKQueryOperation.Cursor?) = (
                matchResults: matchResults,
                queryCursor: nil
            )

        completionHandler(.success(result))
    }

    func oneRecordForEachEntity() {
        self.records = [
            .init(recordType: "Account"),
            .init(recordType: "User"),
            .init(recordType: "Company"),
            .init(recordType: "Rating"),
            .init(recordType: "Service"),
            .init(recordType: "Appointment")
        ]
    }
}
