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
}]

$(document).ready ->
  return unless $("#home.section")
  randBg = Math.floor((Math.random() * 6) + 1)
  $("#home").removeClass("person-1 person-2 person-3 person-4 person-5 person-6")
  $("#home").addClass("person-#{randBg}")

  rIndex = Math.floor(Math.random()*homeData.length)
  chosenHomeData = homeData[rIndex]
  $("#home h1").html(chosenHomeData['h1'])
  $("#home h2").html(chosenHomeData['h2'])
  $("#home p").html(chosenHomeData['p'])
  $("#home h4 .article_source").html(chosenHomeData['as'])
  $("#home h4 a.article_link").attr('href',chosenHomeData['al'])
  $("#home h4 a.article_link").html(chosenHomeData['at'])

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
