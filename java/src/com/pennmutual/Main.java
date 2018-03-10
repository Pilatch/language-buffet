package com.pennmutual;

import com.pennmutual.JsonStrings;
import com.google.gson.*;

import java.io.IOException;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import com.github.fge.jsonschema.core.exceptions.ProcessingException;
import com.github.fge.jsonschema.core.report.ProcessingReport;
import com.github.fge.jsonschema.main.JsonSchema;
import com.github.fge.jsonschema.main.JsonSchemaFactory;


public class Main {

  static class Player {
	  String name;
	  Float winPercent;
  }
	
  static void introduce(Player player) {
	  if (player.winPercent == null) {
		  System.out.println(String.format("%s is a new player.", player.name));
	  } else {
		  System.out.println(String.format("%s wins %f%% of the time.", player.name, player.winPercent));
	  }
  }

  static boolean isValidPlayer(String playerJson) {
	  ObjectMapper mapper = new ObjectMapper();
	  try {		  
		  JsonNode playerSchemaNode = mapper.readTree(JsonStrings.playerSchema);
		  JsonNode playerNode = mapper.readTree(playerJson);
	      JsonSchemaFactory factory = JsonSchemaFactory.byDefault();
	      JsonSchema schema = factory.getJsonSchema(playerSchemaNode);
	      ProcessingReport report;
	      report = schema.validate(playerNode);
	      if (report.isSuccess()) {	    	  
	    	  return true;
	      }
	      
	      System.err.println(report);
	      return false;
	  } catch (IOException ioe) {
		  System.err.println("IO Error " + ioe);
		  return false;
	  } catch (ProcessingException pe) {
		  System.err.print("Processing Error " + pe);
		  return false;
	  }
  }
  
  public static void main(String[] args) {
	  Gson gson = new Gson();
	  Player player = null;

	  try {
		  String jsonToUse = JsonStrings.goodJson;
		  if (isValidPlayer(jsonToUse)) {			  
			  player = gson.fromJson(jsonToUse, Player.class);
			  introduce(player);
		  }
	  } catch (JsonSyntaxException jse) {
		  System.out.println("Here's what went wrong. \n\n" + jse.getMessage());
	  }
  }

}
