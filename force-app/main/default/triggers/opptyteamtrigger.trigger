trigger opptyteamtrigger on OpportunityTeamMember (before insert) {
  
  OpportunityTeamMember opp = [select id from OpportunityTeamMember where id =: trigger.new[0].id]; 
  insert opp;
}