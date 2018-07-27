import Foundation
import UIKit

protocol ComicViewDelegate {
    var comic: XKCDComic? {get set}
    func handleMostRecentClicked()
    func handlePrevClicked()
    func handleNextClicked()
    func handleRandomClicked()
    func handleSelectedComicNumber(_ number: Int)
}
