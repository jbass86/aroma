# Author: Josh Bass
# Description: Purpose of main here is to create the main react component and lay out all of the
#              sub components
window.$ = window.jQuery = window.jquery = require("jquery");
require('bootstrap');

React = require("react");
ReactDOM = require("react-dom");
css = require ("css/main.css");


HeaderBar = require("components/header_bar/HeaderBarView.coffee");
NavigationBar = require("components/navigation_bar/NavigationBarview.coffee");
LoginView = require("components/login/LoginView.coffee");

Inventory = require("components/inventory/InventoryView.coffee");
Customers = require("components/customers/CustomerView.coffee");

Backbone = require("backbone");

$(() ->

  nav_model = new Backbone.Model();

  comp = React.createClass

    getInitialState: () ->
      return {authenticated: false, remove_login: false};


    componentDidMount: () ->
      console.log("mounted main comp");


    render: () ->
      <div>
        <div className={@getLoginClasses()}>
          <LoginView login_success={@handleLoginSuccess}/>
        </div>
        {@renderMain()}
      </div>

    renderMain: () ->
      if (@state.authenticated)
        <div>
          <NavigationBar nav_model={nav_model}/>

          <div className={"header-area" + @getMainClasses()}>
            <HeaderBar nav_model={nav_model}/>
          </div>

          <div className={"main-area" + @getMainClasses()}>
            <Inventory />
            <Customers />
          </div>
        </div>
      else
        <div style={{"width": "100vw", "height": "100vh"}}></div>

    getLoginClasses: () ->
      console.log("get login classes!");
      classes = "";
      if (@state.authenticated)
        classes += " fade-out";
      if (@state.remove_login)
        classes += " display-none";
      classes;

    getMainClasses: () ->
      classes = "";
      if (@state.authenticated)
        classes += " fade-in";
      else
        classes += " fade-out"
      classes;

    handleLoginSuccess: (token) ->
      window.token = token;
      @setState({authenticated: true});
      window.setTimeout(()=>
        @setState({remove_login: true});
      , 1000);

  ReactDOM.render(React.createElement(comp, null), $("#react-body").get(0));

  # $.post("aroma/create_user", {username: "Josh", password: "Bass"}, (response) =>
  #   console.log(response);
  # );
);
