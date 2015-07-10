var CampaignsListing = React.createClass({
  getInitialState: function() {
    return {campaigns: [], showSpinner: true};
  },
  componentDidMount: function() {
    $.ajax({
      method: "GET",
      url: "http://localhost:3000/campaigns.json",
      success: function(data){
        this.setState({campaigns: data, showSpinner: false});
      }.bind(this)
    });
  },
  render: function() {
    var campaigns = this.state.campaigns.map(function(c){
      return <Campaign title={c.title} id={c.id} />;
    });
    var spinnerDisplay = this.state.showSpinner ? "block" :  "none" ;
    var spinnerStyle   = {display: spinnerDisplay};
    return <div>
             <h1>Fund.sy</h1>
             <div style={spinnerStyle}>Loading...</div>
             {campaigns}
           </div>;
  }
});

var Campaign = React.createClass({
  getInitialState: function(){
    return {reward_levels: [],
            description: "",
            comments: [],
            detailsFetched: false}
  },
  fetchDetails: function(){
    $.ajax({
      url: "http://localhost:3000/campaigns/" + this.props.id + ".json",
      method: "GET",
      success: function(data) {
        console.log(data);
        this.setState({
          description: data.campaign.description,
          comments: data.comments,
          reward_levels: data.reward_levels,
          detailsFetched: true
        });
      }.bind(this)
    })
  },
  render: function() {
    if(this.state.detailsFetched) {
      var reward_levels = this.state.reward_levels.map(function(rl){
        return <div>
                {rl.title}(${rl.amount}): {rl.description}
              </div>;
      });
      var comments = this.state.comments.map(function(c){
        return <div>{c.body}</div>;
      });
      return <div>
                <h2>{this.props.title}</h2>
                <h3>Reward Levels</h3>
                {reward_levels}
                <h3>Comments</h3>
                {comments}
             </div>;
    } else {
      return <div>
              <a href="#" onClick={this.fetchDetails}>{this.props.title}</a>
             </div>;
    }
  }
});
