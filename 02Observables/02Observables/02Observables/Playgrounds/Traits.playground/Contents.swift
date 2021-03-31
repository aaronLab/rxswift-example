import Foundation
import RxSwift

let bag = DisposeBag()

enum FileReadError: Error {
    
    case fileNotFound, unreadable, encodingFailed
    
}

extension FileReadError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Error!: File not found."
        case .unreadable:
            return "Error!: Unredable"
        case .encodingFailed:
            return "Error!: Encoding failed."
        }
    }
    
}

func loadText(from name: String) -> Single<String> {
    
    return Single.create { single -> Disposable in
        
        let disposable = Disposables.create()
        
        guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
            single(.failure(FileReadError.fileNotFound))
            return disposable
        }
        
        guard let data = FileManager.default.contents(atPath: path) else {
            single(.failure(FileReadError.unreadable))
            return disposable
        }
        
        guard let contents = String(data: data, encoding: .utf8) else {
            single(.failure(FileReadError.encodingFailed))
            return disposable
        }
        
        single(.success(contents))
        return disposable
        
    }
    
}

loadText(from: "Lorem")
    .subscribe {
        
        switch $0 {
        case .success(let string):
            print(string)
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
    .disposed(by: bag)

loadText(from: "Error")
    .subscribe {
        
        switch $0 {
        case .success(let string):
            print(string)
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
    .disposed(by: bag)
