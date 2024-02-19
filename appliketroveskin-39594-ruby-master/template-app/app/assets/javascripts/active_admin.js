//= require arctic_admin/base
//= require activeadmin_addons/all
//= require chartkick

$(document).ready(function(){

  hideShowTags();
  validateImageDimension();
  addNote();
  loadCalendarData();
  loadProducts();
  openLinksInNewTab();
  validateAdvertisementImage();
  showSelectedFilter();
  validateCkeditorField();
  customerFilters();
  refreshproducts();
  addmoney();
  validatePasswordFields();
  blogsFilters();
  dashboardFilters();
  // searchproduct();
  // refresh();
  $('textarea').attr('rows', 5);

  $( "#tags_type" ).bind('change', function() {
    tagsType = document.getElementById("tags_type")
    tags = document.getElementById("hero_product_tags_input")
  
    if (tagsType.value == "default")
      tags.setAttribute("hidden", "");
    else
      tags.removeAttribute("hidden");
  });
  $('#tags_type').trigger('change');

  $( "#interval" ).bind('change', function() {
    interval = document.getElementById("interval")
    time = document.getElementById("elite_eligibility_time_input")
    frequency = document.getElementById("elite_eligibility_frequency_input")
    if (interval.value != "lifetime"){
      time.removeAttribute("hidden");
      frequency.removeAttribute("hidden");
    }
    else{
      time.setAttribute("hidden", "");
      frequency.setAttribute("hidden", "");
    }
  });
  $('#interval').trigger('change');

  $( "#eligibility_on" ).bind('change', function() {
    eligibility_on = document.getElementById("eligibility_on")
    product_type = document.getElementById("elite_eligibility_product_type_input")
  
    if (eligibility_on.value == "product_bought")
      product_type.removeAttribute("hidden");
    else
      product_type.setAttribute("hidden", "");
  });
  $('#eligibility_on').trigger('change');

  if($('#bx_block_explanation_text_explanation_text_value').length > 0)
    CKEDITOR.addCss(".cke_editable{background-color: slategrey}");
    
    params = window.location.search.replace("?","");
    id = params[0] == '&' ? params.split('&')[1] : params.split('&')[0]
    id = id.split('=')[0]
    element = document.getElementById(id);
    if (element != null){
      element.scrollIntoView({
        behavior: 'auto',
        block: 'center',
        inline: 'center'
    });
  }
  let value = ""
  let key = ""
  if (window.location.href.includes('?')){
      key = window.location.href.split("?")[1].split("=")[0];
      value = window.location.href.split("?")[1].split("=")[1];
  }
  countryElement = document.getElementsByClassName('country');

  if(value!="" && countryElement.length != 0 && countryElement[0].value != value){
    countryElement[0].value = decodeURIComponent(value);
    $('.country').trigger('change');
  }
  else if (countryElement.length != 0 && countryElement[0].value == ""){
    countryElement[0].value = "Ireland";
    $('.country').trigger('change');
  }

  $('select').change(function(){
    if (countryElement.length != 0){
      country = countryElement[0].value;
      if ((value!="" || country == "United Kingdom") && country!= decodeURIComponent(value)){
        url = window.location.href.split("?")[0];
        str = "?country="+country;
        window.location.href = url + str;
      }
    }
  });

  $( "#notification_user_type" ).bind('change', function() {
    elem = document.getElementsByClassName('notification_account_ids')
    userType = document.getElementById("notification_user_type")
    if (userType.value != "select_customers")
      elem[0].setAttribute("hidden", "");
    else
      elem[0].removeAttribute("hidden");
  });
  $('#notification_user_type').trigger('change');

  $('#advertisement_url').on('input',function(e){
    if ($(this).val() != ""){
      $('#advertisment_product_id').val("").change();
      $('#advertisment_appointment_id').val("").change();
    }
  });

  $('#advertisment_product_id').bind('change', function(){
    if ($(this).val() != ""){
      $('#advertisement_url').val("").change();
      $('#advertisment_appointment_id').val("").change();
    }
  });

  $('#advertisment_appointment_id').bind('change', function(){
    if ($(this).val() != ""){
      $('#advertisement_url').val("").change();
      $('#advertisment_product_id').val("").change();
    }
  });
});


function openLinksInNewTab(){
  $('.download_links').children('a').each(function(index){
    if(index != 0)
      $(this).attr('target', "_blank");
  });
}

function hideShowTags(){
  $('#bx_block_facialtracking_skin_quiz_question_type').change(function(){
    selected_value = $(this).val();
    checkQuestionType(selected_value)
  })

  selected_value = $('#bx_block_facialtracking_skin_quiz_question_type').val();
  $('.has_many_container').bind('DOMNodeInserted', function() {
    checkQuestionType(selected_value);
    validateImageDimension();
  });

  checkQuestionType(selected_value)
}

function checkQuestionType(selected_value)
{
  if(selected_value == "skin_log" || selected_value == "skin_goal"){
    $('.skin_quiz_tags').hide();
    $('.allows_multiple').show();
    $('.answer_image').show();
  }
  else if(selected_value == "sign_up"){
    $('.skin_quiz_tags').show();
    $('.allows_multiple').hide();
    $('.answer_image').hide();
  }
}

function validateImageDimension(){
  $('.life_event_image, .answer_image').change(function(e){
    dropdown = $(this);
    var reader = new FileReader();
    maxHeight = $(this).attr('class').includes("life_event_image") ? 650 : 50
    input_class = $(this).attr('class').includes("life_event_image") ? 'life_event_image' : 'answer_image'
    reader.readAsDataURL(e.target.files[0]);
    reader.onload = function (e) {

    var image = new Image();
    image.src = e.target.result;

    image.onload = function () {
      var height = this.height;
      var width = this.width;
      if (height != maxHeight || width != maxHeight){
        $(dropdown).find('#error').length < 1 ? $(dropdown).append('<div id="error"><span class="error">Image height and width must be ' + maxHeight + 'px.</span></div>') : '';
        $("input[type=submit]").attr("disabled", true);
      }
      else{
        $(dropdown).children('#error').remove();
        $('div#error').length == 0 ? $("input[type=submit]").attr("disabled", false) : '';
      }
    };
  }
  });
}

function addNote(){
  $('.life_event_image').append("<div><span class='note'>Note* - Image height and width must be of 650px</span></div>");
  $('.answer_image').append("<div><span class='note'>Note* - Image height and width must be of 50px</span></div>");
  $('.has_many_container').bind('DOMNodeInserted', function() {
    $('.life_event_image').each(function(){
      $(this).find('span.note').length == 0 ? $(this).append("<div><span class='note'>Note* - Image height and width must be of 650px</span></div>") : ''
    });
    $('.answer_image').each(function(){
      $(this).find('span.note').length == 0 ? $(this).append("<div><span class='note'>Note* - Image height and width must be of 50px</span></div>") : ''
    });
  });
}

function loadCalendarData(){
  if($('#filter_by_therapist').length > 0)
  {
    options = $('#filter_by_therapist').attr("collection");
    splitted_options = options.split("[")

    $('#filter_by_therapist').append("<option value='0'>Select Therapist</option>");
    for(i=0; i<splitted_options.length;i++){
      id = name = "";
      if(splitted_options[i] != ""){
        record = splitted_options[i].trim().split(',')
        id = record[1].trim().replaceAll("]","");
        name = record[0].replaceAll("\"", "");
        $('#filter_by_therapist').append("<option value='" + id +"'>" + name + "</option>");
      }
    }

    $('#filter_appointments').click(function(){
      url = $(this).attr('href');
      calendar_id = $('#filter_by_therapist').val();
      start_date = $('#start_date').val();
      end_date = $('#end_date').val();
      if(calendar_id != "0" && calendar_id != null)
        $(this).attr("href", url + "?calendar_id=" + calendar_id)
      if(start_date != '' && end_date != ''){
        href = $(this).attr('href');
        href.includes("?") ? $(this).attr("href", href + "&start_date=" + start_date + "&end_date=" + end_date) : $(this).attr("href",  href + "?start_date=" + start_date + "&end_date=" + end_date);;
      }
    });
  }
}

function loadProducts(){
  if($('#filter_by_status').length > 0)
  {
    options = $('#filter_by_status').attr("collection");
    splitted_options = options.split("[")
    $('#filter_by_status').append("<option value='0'>Select Status</option>");
    for(i=0; i<splitted_options.length;i++){
      id = name = "";
      if(splitted_options[i] != ""){
        record = splitted_options[i].trim().split(',')
        id = record[1].trim().replaceAll("]","");
        name = record[0].replaceAll("\"", "");
        $('#filter_by_status').append("<option value='" + id +"'>" + name + "</option>");
      }
    }

    $('#filter_products').click(function(){
      url = $(this).attr('href');
      status = $('#filter_by_status').val();
      type = $('#type').val();
      vendor = $('#vendor').val();
      // if(calendar_id != "0" && calendar_id != null)
        $(this).attr("href", url + "?status=" + status)
      // if(start_date != '' && end_date != ''){
        href = $(this).attr('href');
        href.includes("?") ? $(this).attr("href", href + "&type=" + type + "&vendor=" + vendor) : $(this).attr("href",  href + "?type=" + type + "&vendor=" + vendor);;
      // }
    });

  }
}

function searchproduct(elem){
  // $('#search_link').click(function(){
    url = elem.href;
    search = $('#listing-search').val();
    elem.setAttribute("href", url + "?search=" + search);
    // $(this).attr("href", url + "?search=" + search);
  // });
}

function refreshproducts(){
    $('#refresh_button').click(function(){
      // event.preventDefault();
      var element = $(this); // if you need some data from radio button
      region = this.getAttribute('value');
      // $('.last_updated').html("Last updated at: Just Now");
      console.log(region);
      $.ajax({
        url: '/bx_block_catalogue/products/refresh_products.json',
        type: 'GET',
        data: {data: region},
        dataType: "json",
        success:function(data){
          alert('Product updated');
          location.reload();
          document.getElementById("last_updated").innerHTML = "Last updated at: Just Now";
        },
        error:function(error){
            alert('error');
            console.log(error);
            // return false;
        },
      });
      return false;

      // $.get("/bx_block_catalogue/products/refresh_products", {data: region}, function(data){
      //   alert("Response is => " + data);
      // });

    });
}

function addmoney(){
  $('#add_money').click(function(){
    amount = document.getElementById('amount').value
    id = this.getAttribute('value')
    $.ajax({
      url: '/bx_block_payments/payments/update_wallet.json',
      type: 'PATCH',
      data: {amount: amount, id: id, token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0NjA2NTgxODZ9.xsSwcPC22IR71OBv6bU_OGCSyfE89DvEzWfDU0iybMA"},
      dataType: "json",
      success:function(data){
        alert('Amount updated');
        // document.querySelector('.row-wallet_balance td').innerHTML = data;
      },
      error:function(error){
          alert('error');
          console.log(error);
          // return false;
      },
    });
  });
}

function validateAdvertisementImage(){
  $('#advertisement_dimension_input').change(function(){
    selected_value = $("input[name='advertisement[dimension]']:checked").val();
    data = selected_value.split(" * ");
    maxWidth = data[0]
    maxHeight = data[1]
    if(typeof($('input[name="advertisement[image]"]')[0].files[0]) != "undefined")
      $('.advertisement_image').change();
  });

  $('.advertisement_image').change(function(e){
    dropdown = $(this)
    dimension = $("input[name='advertisement[dimension]']:checked").val();
    data = dimension.split(" * ");
    maxWidth = data[0]
    maxHeight = data[1]
    validateAdvertisementImageDimension(maxWidth, maxHeight);
  });
}

function validateAdvertisementImageDimension(maxWidth, maxHeight){
    var reader = new FileReader();
    reader.readAsDataURL($('input[name="advertisement[image]"]')[0].files[0]);
    reader.onload = function (e) {

    var image = new Image();
    image.src = e.target.result;

    image.onload = function () {
      var height = this.height;
      var width = this.width;
      if (height != maxHeight || width != maxWidth){
        $(dropdown).find('#error').remove();
        $(dropdown).append('<div id="error"><span class="error">Image width and height must be ' + maxWidth + 'px and ' + maxHeight + 'px accordingly.</span></div>');
        $("input[type=submit]").attr("disabled", true);
      }
      else{
        $(dropdown).children('#error').remove();
        $('div#error').length == 0 ? $("input[type=submit]").attr("disabled", false) : '';
      }
    };
  }
}

function showSelectedFilter(){
  pathname = window.location.pathname.split('/');
  if(pathname[pathname.length - 1] == "appointments" && window.location.search != '')
  {
    params = window.location.search.replace("?","");
    if(params.includes("&"))
    {
      added_params = params.split("&");
      for(a in added_params)
      {
        data = added_params[a];
        keys = data.split("=");
        if(keys[0] == "calendar_id")
          $('option[value="' + keys[1] + '"]').attr("selected", true);
        if(keys[0] == "start_date" || keys[0] == "end_date")
          $('#' + keys[0]).val(keys[1]);
      }
    }
    else
    {
      therapist_data = params.split("=");
      $('option[value="' + therapist_data[therapist_data.length - 1]+ '"]').attr("selected", true);
    }
  }
}

function validateCkeditorField(){
  pathname = window.location.pathname.split('/');
  if((pathname[pathname.length - 1] != "new" && $('#bx_block_faqs_faq_answer').val() == '') || (pathname[pathname.length - 1] != "explanation_texts" && $('#bx_block_explanation_text_explanation_text_value').val() == '') || (pathname[pathname.length - 1] != "new" && $('#bx_block_consultation_consultation_type_description').val() == '')){
    window.setTimeout(function(){
      $('.cke_inner').css("border","1px solid red");
      $('.form_label').css("color", "red");
      if($('#cke_bx_block_faqs_faq_answer').length > 0)
        $('#cke_bx_block_faqs_faq_answer').after("<p class='inline-errors'>can't be blank</p>");
      if($('#cke_bx_block_explanation_text_explanation_text_value').length > 0)
        $('#cke_bx_block_explanation_text_explanation_text_value').after("<p class='inline-errors'>can't be blank</p>");
      if($('#cke_bx_block_consultation_consultation_type_description').length > 0)
        $('#cke_bx_block_consultation_consultation_type_description').after("<p class='inline-errors'>can't be blank</p>");
    }, 1000);
    if($('#account_ids').val() == '')
    {
      $('.label').css('color', 'red');
      $('.select2-selection').css("border","1px solid red");
      $('.select2-selection').after("<p class='inline-errors' style='padding: 0px;'>can't be blank</p>");
    }
  }

}

function customerFilters(){

  $('#filter_customers').click(function(){
    url = $(this).attr('href');
    email = $('#email').val();
    first_name = $('#first_name').val();
    last_name = $('#last_name').val();
    str = "";
    if(email != "")
      str += `email=${email}&`
    if(first_name != ''){
      str += `first_name=${first_name}&`
    }
    if(last_name != ''){
      str += `last_name=${last_name}`;
    }
    if (!str.length==0)
    $(this).attr("href", url + `?${str}`)
  });

}

function validatePasswordFields(){
  if($('#account_password').length > 0 && $('#account_confirm_password').length > 0)
  {
    $("input[type=submit]").click(function(){
      password = $('#account_password').val();
      input_failed = true;
      confirm_password = $('#account_confirm_password').val();
      pathname = window.location.pathname.split('/');
      if(pathname[pathname.length - 1] == 'new' || pathname[pathname.length - 1] == 'mobile_admins')
      {
        if(password == ''){
          $('#account_password').parent('li').addClass('error');
          $('#account_password').siblings('p.password-error').length <= 0 ? $('#account_password').after("<p class='inline-errors password-error' style='padding: 0px;'>can't be blank</p>") : '';
          input_failed = false;
        }
        if(confirm_password == ''){
          $('#account_confirm_password').parent('li').addClass('error');
          $('#account_confirm_password').siblings('p.password-error').length <= 0 ? $('#account_confirm_password').after("<p class='inline-errors password-error' style='padding: 0px;'>can't be blank</p>") : '';
          input_failed = false;
        }
      }
      if(confirm_password != '' && password != '' && confirm_password != password)
      {
        $('#account_confirm_password').siblings('p.password-error').remove();
        $('#account_password').siblings('p.password-error').remove();
        $('#account_confirm_password').parent('li').addClass('error');
        $('#account_password').parent('li').addClass('error');
        $('#account_confirm_password').after("<p class='inline-errors password-error' style='padding: 0px;'>Password and confirm password must be same.</p>");
        input_failed = false;
      }
      return input_failed;
    });
  }
}

function blogsFilters(){

  $('#blogs_filter').click(function(){
    url = $(this).attr('href');
    blog_id = $('#blog_filter').val();
    str = "";
    if(blog_id != "0")
      str += `blog_id=${blog_id}`
    if (!str.length==0)
    $(this).attr("href", url + `?${str}`)
  });

    if($('#blog_filter').length > 0)
    {
      options = $('#blog_filter').attr("collection");
      splitted_options = options.split("[")
      $('#blog_filter').append("<option value='0'>Select Blog</option>");
      for(i=0; i<splitted_options.length;i++){
        id = name = "";
        if(splitted_options[i] != ""){
          record = splitted_options[i].trim().split(',')
          id = record[1].trim().replaceAll("]","");
          name = record[0].replaceAll("\"", "");
          $('#blog_filter').append("<option value='" + id +"'>" + name + "</option>");
        }
      }
    }
}

function dashboardFilters(){
  $('#top_forum_filter').click(function(){
    url = $(this).attr('href');
    start_date = $('#top_forum_start_date').val();
    end_date = $('#top_forum_end_date').val();
    href = $(this).attr('href');
    str = "";
    if(start_date != "")
      str += `top_forum_start_date=${start_date}`
    if(end_date != "")
      str += `&top_forum_end_date=${end_date}`
    if (!str.length==0)
      href.includes("?") ? $(this).attr("href", url + `&${str}`) : $(this).attr("href", url + `?${str}`);
  });

  $('#top_blogs_filter').click(function(){
    url = $(this).attr('href');
    start_date = $('#top_blog_start_date').val();
    end_date = $('#top_blog_end_date').val();
    href = $(this).attr('href');
    str = "";
    if(start_date != "")
      str += `top_blog_start_date=${start_date}`
    if(end_date != "")
      str += `&top_blog_end_date=${end_date}`
    if (!str.length==0)
      href.includes("?") ? $(this).attr("href", url + `&${str}`) : $(this).attr("href", url + `?${str}`);
  });

  $('#forum_views_filter').click(function(){
    url = $(this).attr('href');
    start_date = $('#forum_start_date').val();
    end_date = $('#forum_end_date').val();
    href = $(this).attr('href');
    str = "";
    if(start_date != "")
      str += `forum_start_date=${start_date}`
    if(end_date != "")
      str += `&forum_end_date=${end_date}`
    if (!str.length==0)
      href.includes("?") ? $(this).attr("href", url + `&${str}`) : $(this).attr("href", url + `?${str}`);
  });

  $('#blog_views_filter').click(function(){
    url = $(this).attr('href');
    start_date = $('#blog_start_date').val();
    end_date = $('#blog_end_date').val();
    href = $(this).attr('href');
    str = "";
    if(start_date != "")
      str += `blog_start_date=${start_date}`
    if(end_date != "")
      str += `&blog_end_date=${end_date}`
    if (!str.length==0)
      href.includes("?") ? $(this).attr("href", url + `&${str}`) : $(this).attr("href", url + `?${str}`);
  });

  $('#top_spenders_filter').click(function(){
    url = $(this).attr('href');
    start_date = $('#top_spenders_start_date').val();
    end_date = $('#top_spenders_end_date').val();
    href = $(this).attr('href');
    str = "";
    if(start_date != "")
      str += `top_spenders_start_date=${start_date}`
    if(end_date != "")
      str += `&top_spenders_end_date=${end_date}`
    if (!str.length==0)
      href.includes("?") ? $(this).attr("href", url + `&${str}`) : $(this).attr("href", url + `?${str}`);
  });

  $('#sales_filter').click(function(){
    url = $(this).attr('href');
    start_date = $('#sales_start_date').val();
    end_date = $('#sales_end_date').val();
    href = $(this).attr('href');
    str = "";
    if(start_date != "")
      str += `sales_start_date=${start_date}`
    if(end_date != "")
      str += `&sales_end_date=${end_date}`
    if (!str.length==0)
      href.includes("?") ? $(this).attr("href", url + `&${str}`) : $(this).attr("href", url + `?${str}`);
  });

  $(function() {
    title = $('#page_title').html();
    if (title == 'UK')
      $('.sidebar').append('<div><input id="listing-search" type="text" placeholder="Search Product" style = "width: 50%; display: inline; margin-bottom: 2%; margin-left: 17%; margin-right: 2%"></input><a class="link" id="search_link" href="/admin/uk" onClick="searchproduct(this)" style="display: inline; padding: 9px 8px;" >Search</a></div>');
    if (title == 'Ireland')
      $('.sidebar').append('<div><input id="listing-search" type="text" placeholder="Search Product" style = "width: 50%; display: inline; margin-bottom: 2%; margin-left: 17%; margin-right: 2%"></input><a class="link" id="search_link" href="/admin/ireland" onClick="searchproduct(this)" style="display: inline; padding: 9px 8px;">Search</a></div>');
  });

  
}


