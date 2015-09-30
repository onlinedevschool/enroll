homeData = [{
  "h1": "No College Degree Required",
  "h2": "Welcome to your new life as a Web Developer",
  "p" : "In as little as <strong>12 weeks</strong> you could be making <strong>$50,000</strong> a year or more!",
  "as": "New York Times",
  "al": "http://www.nytimes.com/2015/07/29/technology/code-academy-as-career-game-changer.html",
  "at": "As Tech Booms, Workers Turn to Coding for Career Change"
},{
  "h1": "No Mountain of Debt Required",
  "h2": "Web Developers are hired on Talent, not degrees",
  "p" : "You don't need a <strong>mountain of debt</strong> or a <strong>college degree</strong> to get hired.",
  "as": "Times - Business",
  "al": "http://business.time.com/2013/05/21/the-7000-computer-science-degree-and-the-future-of-higher-education/",
  "at": "The $7,000 Computer Science Degree — and the Future of Higher Education"
},{
  "h1": "Entrepreneurs make great Devs",
  "h2": "Sometimes if you want it done right, you have to do it yourself",
  "p" : "Build <strong>your own business</strong> instead of <strong>cogging the wheel</strong>",
  "as": "The Guardian",
  "al": "http://www.theguardian.com/technology/us-money-blog/2015/jun/10/millennials-tech-startups-silicon-valley",
  "at": "Millennials founding tech startups: calculated risk with enduring reward"
},{
  "h1": "You graduate when you get a job!",
  "h2": "Unlike other programs, we don't dump you on the doorstep",
  "p" : "At ODS we call it <strong>Enrollment to Hire</strong> education and <strong>we mean it</strong>.",
  "as": "NPR",
  "al": "http://www.npr.org/sections/ed/2014/12/20/370954988/twelve-weeks-to-a-six-figure-job",
  "at": "12 Weeks To A 6-Figure Job"
},{
  "h1": "100% of our Grads have jobs!",
  "h2": "We have partnerships with NGOs to get you work",
  "p" : "At ODS we call it <strong>Enrollment to Hire</strong> education and <strong>we mean it</strong>.",
  "as": "US News",
  "al": "http://money.usnews.com/money/blogs/outside-voices-careers/2014/03/26/thinking-about-a-nonprofit-job-heres-what-you-should-know",
  "at": "What should I know about working for an NGO?"
},{
  "h1": "1 on 1 Mentorship with an Expert",
  "h2": "At ODS you will NOT be taught by an ex student",
  "p" : "We require a <strong>minimum</strong> of <strong>15 years</strong> to teach.</strong>.",
  "as": "CodeMentor",
  "al": "https://www.codementor.io/onlinedevschool",
  "at": "Meet your <strong>new expert Instructor</strong>, Jim!"
}]

$(document).ready ->
  bgs = [1, 2, 3, 5, 6].sort ->
    return .5 - Math.random()

  $(".random-person").each (i, el) ->
    $(el).addClass "person-#{bgs[i]}"

  smoothScroll.init
    speed: 1000
    easing: 'easeInOutQuart'
    updateURL: true
    offset: 62

  $('.masonry').masonry
    columnWidth : '.review-callout'
    itemSelector: '.review-callout'

  $(document).find("[data-featherlight]")
             .featherlight()

  topMenu = $("#top-menu")
  topMenuHeight = topMenu.outerHeight()+100
  menuItems = topMenu.find("a")
  scrollItems = menuItems.map ->
    item = $($(this).attr("href"))
    return item if (item.length)

  $(window).scroll ->
    fromTop = $(this).scrollTop()+topMenuHeight
    cur = scrollItems.map ->
      return this if ($(this).offset().top < fromTop)

    cur = cur[cur.length-1]
    id = if (cur && cur.length) then cur[0].id else ""

    menuItems
      .parent()
      .removeClass("active")
      .end()
      .filter("[href=#"+id+"]")
      .parent()
      .addClass("active")
