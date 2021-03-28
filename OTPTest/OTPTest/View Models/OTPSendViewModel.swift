//
//  OTPSendViewModel.swift
//  OTPTest
//
//  Created by Aaron Lee on 2021/03/28.
//

import Foundation
import RxSwift
import RxCocoa

protocol OTPSendViewBindable {
    var sendButtonPressed: PublishRelay<Void> { get }
    var mobileNoValueChanged: PublishRelay<String?> { get }
    var sendOTPResponse: PublishSubject<OTPSendResponse?> { get }
    var isLoading: PublishSubject<Bool> { get }
}

class OTPSendViewModel: OTPSendViewBindable {
    
    var sendButtonPressed: PublishRelay<Void> = PublishRelay<Void>()
    
    var mobileNoValueChanged: PublishRelay<String?> = PublishRelay<String?>()
    
    var sendOTPResponse: PublishSubject<OTPSendResponse?> = PublishSubject<OTPSendResponse?>()
    
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    
    private var requestBody: Observable<OTPSendRequestBody> {
        return mobileNoValueChanged
            .map { OTPSendRequestBody(mobileNo: $0) }
            .asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
        
        sendButtonPressed.withLatestFrom(requestBody)
            .subscribe(onNext: { [weak self] body in
                guard let `self` = self else { return }
                
                let url = URL(string: OTPURL)!
                let request = Request<OTPSendResponse>(url: url)
                let headers = HEADER
                
                self.isLoading.onNext(true)
                
                URLSession.load(request: request, httpMethod: .post, headers: headers, body: body)
                    .retry(3)
                    .subscribe(onNext: { [weak self] response in
                        guard let `self` = self else { return }
                        self.sendOTPResponse.onNext(response)
                        self.isLoading.onNext(false)
                    })
                    .disposed(by: self.disposeBag)
                
            }).disposed(by: disposeBag)
    }
    
}
