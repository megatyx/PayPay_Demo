# PayPay_Demo

Hello! Welcome to my demo for you all. I spent quite some time on this, so I hope to get some good feedback.

## Problems

Before I continue, I would like to address some problems or concerns that you might have looking at it.

### Limited Functionality -- Why do some functions not work?
Simply because the fixer API is limited and I'm unwilling to pay to unlock those features for the purposes of a demo. Simple things like, changing the base currency, or currency conversion are locked behind a paywall. I suggest that PayPay choose a more open API for these purposes in the future.

### Where are the Unit Tests?

While I set out in the preliminary project with Unit Tests, I found that I just didn't have enough time to show off the coding stategy that I wanted to use and maintain good, usable tests. Generally, I like to unit test my models first using Test Driven Development. I will go back and add them at some point if I have time. I wrote in a semi-MVVM structure so that I could unit test better, however, I ended up running out of time.

### Why did you include Core Data if you didn't use it?
This one is out of habbit. Many times, I'll start a new project without core data only to need it later. For me here, just in case I decided to use it, it just made sense to just go ahead and put it there. To me, it's far more easier than trying to add it manually later.

### Factories? Those are old!

I've gotten this criticism before. While I think that it's valid, I only use factories here in two places and only then for URL related things. The reason for this is security concerns. String literals are still exposed in the binaries of iPhone files. If you put your entire URL endpoint in a giant string constants folder, you will expose your endpoints to malicious users. Not only does this factory method help obfuscate endpoints and mitigate this issue, but it has the added benefit of maintaining URL related clensing and realiablility all in one place.

### You made all of these extra views...

I apologize for this one. When I made my original accessment and plan, I thought that the entire Fixer API would be open to me. I had made plans to FULLY implement the "latest" and "convert" endpoints as well as implement their related views. However, the fixer API is really limited to free users. I found out quickly that I wrote a converter, and I couldn't use it, or that I could not even change my base currency.

### There are a lot of "Static" declared variables and functions, why?

Simply because, in Swift, declaring static makes these varables and functions resolve to the same places in memory. It's very useful for reusing constants and certain networking functions. This is one of the small strategies that someone can do to help make Swift a tiny bit faster.

### You didn't handle the keyboard in your "currency conversion" screen.
Yes, here I found that the API was walled off and I ran out of time. I decided to refocus on other places

## Strategy Notes

Here are some notes I'd like to convey on my general strategy in tackling the problem.

### Extensibility

I wrote this particular application to be infinitely extensibile throughout most of the files. This way, if the project ever grows, someone adding to the project can simply just add a new file and extend existing stuctures. For Example:
In the file: "APIHandler.swit" you can see the following
```
struct APIHandler {}
```
This is on purpose to illustrate the fact that it's a base structure. Looking on, you can see that I employed that strategy here in "GetLatestAPI.swift"
```
extension APIHandler {
static func getLatest(base: String? = nil, symbols: [String]? = nil, success: @escaping (String?, CurrencyRates) -> Void, failure: @escaping (APIError?) -> Void) {
        ...
    }
}
```
You can add many endpoints this way or even add substructs to better organize these functions.
Another good example of this is the Constants struct

### Value vs Reference --- structs everywhere

If you noticed, I really went out of my way to try to use Swift structs as much as possible. This is because, in general, swift structs are memory safe and can be faster than classes in some instances. There would almost never be a strong retain cycle for a Swift struct. Since most of my models were small, and I just went for it. Plus, conforming to the Codable protocols in swift structs make parsing network data blazingly fast.

### Function over strict conformity for MCV vs. MVVM

In general, I tried to go for an MVVM strategy but there was a little bleed over. MVVM has always had the problem with the View Models desyncing from the View itself. It's one of the problems with using a style that's not really officially supported by Apple's API and SDK. Here, I tried to extract logic into the View Model that made sense as much as possible. It might have taken longer to write proper observers or a sync layer, so I opted out of going that far in depth for the purposes of this assignment.

### Universal interface

I made sure that, when I designed all interfaces, they looked decent on all iOS devices. Go ahead and give it a try on your ipad simulator.

# Conclusion
Thank you for your time and consideration. Please feel free to contact me anytime if you have any qustions.
