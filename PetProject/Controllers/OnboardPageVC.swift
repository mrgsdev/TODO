//
//  OnboardPageVC.swift
//  PetProject
//
//  Created by MRGS on 09.09.2022.
//

import UIKit

class OnboardPageVC: UIPageViewController {
    var pages = [UIViewController]()
    let vc = WelcomeVC()
    // external controls
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution  = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 9
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let skipButton:CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistBold,sizeFont: 20, borderWidth: 0,
                             cornerRadius: 10,translatesAutoresizingMaskIntoConstraints: false)
        button.setTitle("SKIP", for: .normal)
        button.backgroundColor = UIColor.TextField.label
        button.setTitleColor(.white, for: .normal)
     
        return button
    }()
    let nextButton:CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistBold,sizeFont: 24, borderWidth: 0,
                             cornerRadius: 10,translatesAutoresizingMaskIntoConstraints: false)
        button.setTitle("NEXT", for: .normal)
        button.backgroundColor = UIColor.Button.background
        button.setTitleColor(UIColor.Button.label, for: .normal)
        return button
    }()
    let pageControl = UIPageControl()
    var initialPage = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension OnboardPageVC {
    
    func setup() {
        dataSource = self
        delegate = self
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
        skipButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        let page1 = SettingPageVC(imageName: imageSet.thinkingFace.rawValue,
                                             titleText: "NOTODES",
                                             subtitleText: "Write your thoughts in the notes to come back to later")
        let page2 = SettingPageVC(imageName: imageSet.smileface.rawValue,
                                             titleText: "Sing Up/In",
                                             subtitleText: "Sign up to keep your entries forever")
        let page3 = SettingPageVC(imageName: imageSet.moneyface.rawValue,
                                  titleText: "Completely free of charge",
                                subtitleText: "The app is completely free")
    
     
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.PageControl.pageActive
        pageControl.pageIndicatorTintColor = UIColor.PageControl.pageBackground
        pageControl.numberOfPages = pages.count + 1
        pageControl.currentPage = initialPage
    }
    
    func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(skipButton)
        stackView.addArrangedSubview(nextButton)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: stackView.topAnchor,constant: -14),
            
            skipButton.heightAnchor.constraint(equalToConstant: 56),
            skipButton.widthAnchor.constraint(equalToConstant: 56),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
}

// MARK: - DataSource

extension OnboardPageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
         
        if currentIndex == 0 {
            return  nil
        }  else { // go previous
            
            return pages[currentIndex - 1]
        
        }
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            nextButton.setTitle("Next", for: .normal)
            return  nil
        }
         
    }
}

// MARK: - Delegates

extension OnboardPageVC: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
       
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
 
    }
    
  
   
}

// MARK: - Actions

extension OnboardPageVC {

    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
 
    }

    @objc func skipTapped(_ sender: UIButton) {
        let vc = WelcomeVC()
        UserDefaults.standard.set(true, forKey: "onboard")
        navigationController?.viewControllers = [vc]
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        print(pageControl.currentPage)
        goToNextPage(animated: true)
        if pageControl.currentPage == 3 {
            UserDefaults.standard.set(true, forKey: "onboard")
            self.navigationController?.viewControllers = [vc]
        }
    }
}

// MARK: - Extensions

extension UIPageViewController {

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
     
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}
